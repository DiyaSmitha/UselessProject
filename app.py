from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
import google.generativeai as genai
from google.generativeai import GenerativeModel
import random
# Configure Gemini API (replace with your API key)
genai.configure(api_key="AIzaSyDkAfPr2MhxSVfHE39ZDfPUzSiIq7Bktbo")
model = GenerativeModel("gemini-1.5-flash")  # Replace with your preferred Gemini model version

app = FastAPI()

# Add CORS middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Allows all origins
    allow_credentials=True,
    allow_methods=["*"],  # Allows all methods
    allow_headers=["*"],  # Allows all headers
)

class PromptRequest(BaseModel):
    prompt: str
    compliment_type: str = "random" 

async def get_creative_response(compliment_type: str) -> str:
    try:
        compliment_words = [
    "amazing",
    "brilliant",
    "clever",
    "creative",
    "dazzling",
    "dynamic",
    "efficient",
    "excellent",
    "fantastic",
    "fabulous",
    "gifted",
    "genius",
    "incredible",
    "ingenious",
    "innovative",
    "inspiring",
    "intelligent",
    "magnificent",
    "marvelous",
    "outstanding",
    "phenomenal",
    "prodigious",
    "remarkable",
    "sharp",
    "skilled",
    "talented",
    "thoughtful",
    "wonderful",
    "wise",
    "witty"
]
        random_word = random.choice(compliment_words)
        type_mapping = {
            "random": f"send me a random compliment ",
            "fun": f"Generate a random fun and playful {random_word} compliment",
            "exciting": f"Generate a random exciting and motivating {random_word} compliment",
            "body_positivity": f"Generate a random body positive {random_word} compliment",
            "comparison": f"Generate a  random {random_word} compliment comparing to something positive",
        }
        response = model.generate_content(type_mapping[compliment_type])
        return response.text.strip()
    except Exception as e:
        print(e)
        raise HTTPException(status_code=500, detail="Failed to generate response")

"""@app.post("/api/compliment")
async def generate_phrase(request: PromptRequest):
    response_text = await get_creative_response(request.prompt)
    return {"response": response_text}"""


@app.get("/api/compliment")
async def generate_compliment(compliment_type):
    # Use user prompt to generate AI compliment
    ai_compliment = await get_creative_response( compliment_type)

    return {"compliment": ai_compliment}


import uvicorn
uvicorn.run(app=app, port=8000)






