FROM python:3.9.2-slim-buster

RUN apt-get update && apt-get install -y wget \
    && apt-get install -y --no-install-recommends gcc libffi-dev musl-dev ffmpeg aria2 python3-pip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY . /app/
WORKDIR /app/

RUN pip3 install --no-cache-dir --upgrade pip \
    && pip3 install --no-cache-dir --upgrade -r requirements.txt \
    && python3 -m pip install -U yt-dlp

# ✅ Run both Gunicorn (webhook) and bot script together
CMD ["bash", "-c", "gunicorn app:app --bind 0.0.0.0:$PORT & python3 main.py"]
