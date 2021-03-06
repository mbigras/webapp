FROM python:3.7 as builder
WORKDIR /app
RUN pip install poetry
RUN python -m venv /venv
RUN /venv/bin/pip install --upgrade pip
COPY app/pyproject.toml app/poetry.lock ./
RUN poetry export --format=requirements.txt | /venv/bin/pip install -r /dev/stdin

FROM python:3.7
COPY --from=builder /venv /venv
WORKDIR /app
COPY app/app.py .
ENV PORT=5000
CMD exec /venv/bin/gunicorn \
	--bind=0.0.0.0:$PORT \
	--workers=3 \
	--worker-tmp-dir=/dev/shm \
	app:app
