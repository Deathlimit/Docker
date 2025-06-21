FROM python:3.11-alpine

WORKDIR /app

RUN apk add --no-cache postgresql-dev gcc musl-dev

RUN pip install --no-cache-dir uv

COPY pyproject.toml .
RUN uv pip install --system --no-cache -r pyproject.toml --extra test && apk del gcc musl-dev

COPY src/ ./src/
COPY tests/ ./tests/

EXPOSE 8087

HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 \
    CMD python -c "import requests; requests.get('http://localhost:8087/health')" || exit 1

CMD ["uvicorn", "src.main:app", "--host", "0.0.0.0", "--port", "8087"]
