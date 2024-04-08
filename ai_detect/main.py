from fastapi import FastAPI, HTTPException

import numpy as np
import re

import json
import spacy

import nltk
nltk.download('punkt')
nltk.download('averaged_perceptron_tagger')
nltk.download('brown')

from spacy.symbols import PUNCT
from collections import Counter

from xgboost import XGBClassifier
import xgboost as xgb

from textblob import TextBlob
import statistics

import joblib
xg_model = joblib.load('xg_model.pkl')
nlp = spacy.load("en_core_web_sm")


def sentiment(text1):
    blob = TextBlob(text1)
    blob.tags
    blob.noun_phrases
    list_Sentiment = []
    for sentence in blob.sentences:
        list_Sentiment.append(sentence.sentiment.polarity)
    st_dev = statistics.pstdev(list_Sentiment)
    mean = statistics.mean(list_Sentiment)
    return mean, st_dev


def find_dif(text1, text2):
    blob1 = TextBlob(text1)
    blob2 = TextBlob(text2)
    tokens_text1 = blob1.words
    tokens_text2 = blob2.words
    diferency = set(tokens_text1) ^ set(tokens_text2)
    return diferency


def process_blob(strText):
    strText_Blob = TextBlob(strText)
    correct_Text = str(strText_Blob.correct())
    diferency = find_dif(strText, correct_Text)

    _mean, _stddev = sentiment(correct_Text)

    if diferency:
        return len(diferency)/2, _mean, _stddev
    else:
        return 0, _mean, _stddev


def numPunct(text_objective):
    doc = nlp(text_objective)
    try:
        num_words = len(doc)
        stopwords = [token for token in doc if token.is_stop]
        number_of_stopwords = len(stopwords)
        punctuation_tokens = [token for token in doc if token.pos == PUNCT]
        number_of_punctuation_marks = len(punctuation_tokens)

        unique_words = set(token.text for token in doc)
        count_unique_words = len(unique_words)

        words_doc = [token.text.lower() for token in doc if token.is_alpha]
        frecuency_words = Counter(words_doc)

        most_word, frec_word = frecuency_words.most_common(1)[0]


        val_numwords = num_words/100

        porc_sw = number_of_stopwords/val_numwords
        porc_punt = number_of_punctuation_marks/val_numwords
        porc_unique_words = count_unique_words/val_numwords

        repet_it = sum(1 for token in doc if token.text.lower() == "it")
        repet_is = sum(1 for token in doc if token.text.lower() == "is")

    except IndexError:
        print("An exception occurred")
        return 0, 0, 0, 0, 0, 0, "0", 0, 0, 0, 0

    return num_words, number_of_stopwords, number_of_punctuation_marks, count_unique_words, repet_it, repet_is, most_word, frec_word, porc_sw, porc_punt, porc_unique_words

app = FastAPI()
@app.post("/")

async def process_data(data: dict):
    try:        
        json_data = json.dumps(data)        
        json_var = json.loads(json_data)        
        json_result = json_var["key1"]
        print(json_result)
       
        bad_words, w_mean, w_std = process_blob(json_result)
        num_words, num_stop_words, num_signs, num_u_words, it, is_, repeat_word, frec_r_word, per_sw, per_sign, perc_u_w = numPunct(json_result)
        print(bad_words, w_mean, w_std, num_words, num_stop_words, num_signs, num_u_words, it, is_, frec_r_word, per_sw, per_sign, perc_u_w)

        list_values = [bad_words, w_mean, w_std, num_words, num_stop_words, num_signs, num_u_words, it, is_, frec_r_word, per_sw, per_sign, perc_u_w]
        array_values = np.array(list_values)
        y_prob_2 = xg_model.predict([array_values])
        y_prob = xg_model.predict_proba([array_values])[:, 1]
        print(y_prob)
        print(y_prob_2)

        result = {"answer": "Probability: " + str(y_prob)}
        return result
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))