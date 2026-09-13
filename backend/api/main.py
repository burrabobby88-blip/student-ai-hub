import base64
import os

from dotenv import load_dotenv
from fastapi import FastAPI, File, HTTPException, UploadFile
from fastapi.middleware.cors import CORSMiddleware
from openai import OpenAI

load_dotenv()

api_key = os.getenv("OPENAI_API_KEY")

if not api_key:
    raise RuntimeError("OPENAI_API_KEY is missing")

client = OpenAI(api_key=api_key)

app = FastAPI(title="StudentAI Hub AI Backend")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=False,
    allow_methods=["*"],
    allow_headers=["*"],
)


@app.get("/")
def home():
    return {
        "status": "ok",
        "message": "StudentAI Hub AI Backend is running 🤖"
    }


@app.post("/analyze")
async def analyze_image(file: UploadFile = File(...)):

    allowed_types = [
        "image/jpeg",
        "image/png",
        "image/webp",
    ]

    if file.content_type not in allowed_types:
        raise HTTPException(
            status_code=400,
            detail="Please upload a JPG, PNG or WEBP image."
        )

    image_bytes = await file.read()

    if not image_bytes:
        raise HTTPException(
            status_code=400,
            detail="Image is empty."
        )

    base64_image = base64.b64encode(image_bytes).decode("utf-8")

    image_data_url = (
        f"data:{file.content_type};base64,{base64_image}"
    )

    prompt = """
You are StudentAI Hub's document scanner.

Carefully analyze the uploaded image.

Identify the actual content in this image.

Rules:
- Read visible text accurately.
- Understand the actual document.
- If it is a question, solve the actual question.
- If it is notes, summarize the actual notes.
- If it is a letter, explain the actual letter.
- Do NOT give a generic answer.
- Do NOT invent missing words, names, numbers or dates.
- If handwriting is unclear, clearly mention it.
- Give a useful student-friendly response.

Use this format:

DOCUMENT TYPE:
[what the image contains]

TEXT / CONTENT:
[important readable content]

SUMMARY:
[actual summary]

IMPORTANT POINTS:
- point 1
- point 2
- point 3

ANSWER / EXPLANATION:
[answer if applicable]

UNCLEAR PARTS:
[mention anything that cannot be read]
"""

    try:
        response = client.responses.create(
            model="gpt-5.6-luna",
            input=[
                {
                    "role": "user",
                    "content": [
                        {
                            "type": "input_text",
                            "text": prompt,
                        },
                        {
                            "type": "input_image",
                            "image_url": image_data_url,
                            "detail": "high",
                        },
                    ],
                }
            ],
        )

        return {
            "success": True,
            "analysis": response.output_text,
        }

    except Exception as e:
        raise HTTPException(
            status_code=500,
            detail=str(e)
        )