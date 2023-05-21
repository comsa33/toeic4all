FROM python:3.10.10-slim-bullseye

ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUTF8=1 \
    PIP_NO_CACHE_DIR=on \
    PIP_DISABLE_PIP_VERSION_CHECK=on

WORKDIR /usr/src/toeic4all_flask

COPY pyproject.toml poetry.lock /usr/src/toeic4all_flask/

RUN apt update -y
RUN apt upgrade -y
RUN pip install poetry
RUN poetry config virtualenvs.create false
RUN if [ -f pyproject.toml ]; then poetry install --no-dev; fi

COPY . /usr/src/toeic4all_flask

EXPOSE 5000

CMD ["flask", "run", "--host=0.0.0.0"]
