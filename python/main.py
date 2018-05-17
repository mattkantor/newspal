import sys, os
import spacy
nlp = spacy.load('en')
def get_ner(sentence):
    doc = nlp(sentence)

# Find named entities, phrases and concepts
    print('[',end="")
    arr = []
    for entity in doc.ents:
        x=('{"text":"%s","type":"%s"}' % (entity.text, entity.label_))
        arr.append(x)
    print(",".join(arr), end="")
    print(']',end="")

get_ner(sys.argv[1])
