from transformers import pipeline
from transformers import Conversation
import torch
import whisper
import speech_recognition as sr
import pyttsx3
import wave
import librosa
import numpy as np
import warnings

# Initialize the text-to-speech engine
engine = pyttsx3.init()
voices = engine.getProperty('voices')
engine.setProperty('voice', voices[1].id)

# Load pre-trained models for translation and conversation
translator = pipeline(task="translation",
                      model="facebook/nllb-200-distilled-600M",
                      torch_dtype=torch.bfloat16) 
chatbot = pipeline(task="conversational",
                   model="facebook/blenderbot-400M-distill")

 
#Speaks the given sentence using the text-to-speech engine.
def speak1(sentece):
    engine.say(sentece)
    engine.runAndWait()

#Translates the given sentence, simulates a conversation, and speaks the bot's response.   
def translator_text(sentence):
    # Translate the sentence from Spanish to English
    text_translated = translator(sentence,
                             src_lang="spa_Latn",
                             tgt_lang="eng_Latn",
                             max_length=400)
    sentence_traslated = text_translated[0]['translation_text']
    # Simulate a conversation (note: this part might need adjustment)
    conversation = Conversation(sentence_traslated)  # Replace with appropriate conversation handling
    conversation = chatbot(conversation)
    conversation = str(conversation)

    # Extract user and bot responses from the conversation
    x = conversation.find("user:")
    x1 = conversation.find("assistant:")
    user =conversation[x+6:x1]
    bot = conversation[x1+12:]
    print("USER: -------> " + user)
    print("BOT ---------> " + bot)
    # Speak the bot's response
    speak1(bot)
    return sentence_traslated

#Converts an audio file to text using Whisper.
def convert_to_text(audio_path: str) -> str:
    try:
        # Load the audio file
        audio, sr = librosa.load(audio_path, sr=16000)
        audio = audio.astype(np.float32)
        # Load the Whisper model
        model = whisper.load_model("base")
        # Transcribe the audio
        result = model.transcribe(audio, language="es", fp16=False)
        text = result["text"]
        return text
    except RuntimeError as e:
        print(f"Error during transcription: {e}")
        return None

r = sr.Recognizer()

with sr.Microphone() as source:
    print("Listening...")
    audio = r.listen(source)    
    sample_rate = audio.sample_rate    
    print("Procesing...")
    with wave.open("recorded.wav", "wb") as wf:
        wf.setnchannels(1)
        wf.setsampwidth(audio.sample_width)
        wf.setframerate(sample_rate)
        wf.writeframes(audio.get_raw_data())
        
text_generated = translator_text(convert_to_text("recorded.wav"))