from fastapi import FastAPI, HTTPException
import json

app = FastAPI()
@app.post("/")
async def process_data(data: dict):
    try:
        json_str = str(data)
        json_str = json_str.replace("'", "\"")
        data_new = json.loads(json_str)
        print(data_new['send1'])
        question = data_new['send1']

        return {"message": "received---> " + question}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))