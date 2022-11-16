FROM rasa/rasa:2.8.0-full

USER root
COPY models .
RUN pip install --upgrade pip 
RUN pip3 install rasa[spacy]
RUN python -m spacy download en_core_web_sm
# RUN python -m spacy link en_core_web_sm en
USER 1001
CMD ["run", "--enable-api", "-m", "/models/20221023-095608.tar.gz"]