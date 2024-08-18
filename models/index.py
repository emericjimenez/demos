import gradio as gr
from transformers import pipeline   # For NLP tasks like translation, summarization
from transformers.utils import logging  # For logging information
logging.set_verbosity_error()   # Set logging level to error to suppress unnecessary messages
import torch  # For tensor operations
from rembg import remove  # For removing image backgrounds
import whisper  # For speech-to-text conversion

def convert_to_text(audio_path: str) -> str:
    #Transcribes an audio file to text using the Whisper model.
    # Args:
    # audio_path: Path to the audio file.
    # Returns:
    # The transcribed text.
    try:
        model = whisper.load_model("base")
        result = model.transcribe(audio_path, fp16=False)
        return result["text"]
    except RuntimeError as e:
        print(f"Error during second transcription: {e}")        
        return None    


def background_remover(input_image):
    # Removes the background from an image.
    # Args:
    # input_image: The input image with a background.
    # Returns:
    # The image without a background.
    
    output_img = remove(input_image)
    return output_img

def translate_text(text, src_lang, tgt_lang):
    # Translates text from one language to another.
    # Args:
    # text: The text to translate.
    # src_lang: The source language code.
    # tgt_lang: The target language code.
    # Returns:
    # The translated text.
    
    translator = pipeline(task="translation",
                          model="facebook/nllb-200-distilled-600M",
                          torch_dtype=torch.bfloat16)
    translated_text = translator(text, src_lang=src_lang, tgt_lang=tgt_lang)
    return translated_text[0]['translation_text'] 
  
def summarize_text(text):
    # Summarizes the given text.
    # Args:
    # text: The text to summarize.
    # Returns:
    # The summarized text.
    
    summarizer = pipeline(task="summarization",
                          model="facebook/bart-large-cnn",
                          torch_dtype=torch.bfloat16)
    summary = summarizer(text, min_length=10, max_length=100)
    return summary[0]['summary_text']
  
principal = gr.Blocks()

title = "AI Deployment Demonstration with Gradio"
translator = "Text Language Translator"
inText = "Text to Process"
SourceLanguage = "Source Language"
TargetLanguage = "Target Language"
OutPutTranslate = "Translation"
TextButTranslate = "Translate"
lbTranslator = "ENTER THE TEXT AT THE TOP AND SELECT THE SOURCE AND TARGET LANGUAGES. VALUES:\n- English = eng_Latn\n- Spanish = spa_Latn\n- French = fra_Latn\n- German = deu_Latn"

summary = "Text Summarizer in multiple languages"
lbTextOrigin = "Enter the text to summarize"
lbTextSummarize = "Summarized text"
lbButtonSummarize = "Summarize"
lbSummary = "ENTER THE TEXT TO SUMMARIZE IN THE TEXT BOX ABOVE"

background = "Image background remover"
uploadimg= "Upload image"
outputimg = "Processed image"
butImgBackground = "Remove background"
lbBackround = "Select the image and click the Remove Background button"

audiotext = "Speech to text"
lbButtonVoiceText = "Convert audio to text"
lbTextVoice = "Obtained text"

lbAudioText = "Upload an audio file or record one with a microphone"

with gr.Blocks() as principal:    
    gr.Markdown(title)
    with gr.Tabs():
        
        with gr.TabItem(audiotext):
             with gr.Row():
                with gr.Column():
                    with gr.Row():
                        audio_input = gr.Audio(type="filepath", label="Upload Audio File")                                                
                    with gr.Row():
                        text_output_voice = gr.Textbox(label=lbTextVoice)
                    with gr.Row():
                        voice_text_button = gr.Button(value="Transcribe", variant="primary")                        
                with gr.Column():
                    gr.Label(lbAudioText)              

        with gr.TabItem(background):
             with gr.Row():
                with gr.Column():
                    with gr.Row():
                        input_image = gr.Image(type='pil', label=uploadimg)
                    with gr.Row():
                        output_image = gr.Image(type='pil', label=outputimg)
                    with gr.Row():
                        background_button = gr.Button(butImgBackground)    
                with gr.Column():
                    gr.Label(lbBackround)              
        
        with gr.TabItem(translator):
             with gr.Row():
                with gr.Column():
                    text_input = gr.Textbox(lines=3, label=inText, max_lines=20)
                    source_lang_dropdown = gr.Dropdown(["eng_Latn", "spa_Latn", "fra_Latn", "deu_Latn"], label=SourceLanguage, value="spa_Latn", visible=True)
                    target_lang_dropdown = gr.Dropdown(["eng_Latn", "spa_Latn", "fra_Latn", "deu_Latn"], label=TargetLanguage, value="eng_Latn", visible=True)
                    text_output = gr.Textbox(label=OutPutTranslate)
                    traslate_button = gr.Button(TextButTranslate)                
                with gr.Column():
                    gr.Textbox(lbTranslator, lines=10)
    
        with gr.TabItem(summary):
             with gr.Row():
                with gr.Column():
                    text_input_summarize = gr.Textbox(lines=3, label=lbTextOrigin)
                    text_output_summarize = gr.Textbox(label=lbTextSummarize)
                    summarize_button = gr.Button(lbButtonSummarize)
                with gr.Column():
                    gr.Label(lbSummary)                    
        
    voice_text_button.click(convert_to_text, inputs=audio_input, outputs=text_output_voice)
    voice_text_button.click(convert_to_text, inputs=input_image, outputs=output_image)                                    
    background_button.click(background_remover, inputs=input_image, outputs=output_image)                
    summarize_button.click(summarize_text, inputs=[text_input_summarize], outputs=text_output_summarize)
    traslate_button.click(translate_text, inputs=[text_input, source_lang_dropdown, target_lang_dropdown], outputs=text_output)

principal.launch()
#principal.launch(
#    server_name="0.0.0.0", 
#    server_port=7860,
#    share=False,
#    debug=False
#)
