from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()

class InputData(BaseModel):
    data: list

@app.post("/predict")
def predict(input_data: InputData):
    return {"prediction": "fake_result"}
