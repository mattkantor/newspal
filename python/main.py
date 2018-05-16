import sys, os
import spacy
nlp = spacy.load('en')
def get_ner(sentence):
    doc = nlp(sentence)

# Find named entities, phrases and concepts
    for entity in doc.ents:
        print(entity.text, entity.label_)


get_ner(sys.argv[1])
