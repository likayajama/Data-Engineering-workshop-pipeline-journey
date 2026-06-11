# base Docker image that we will build on
FROM python:3.13.11-slim

# Copy uv binary from official uv image (multi-stage build pattern)
COPY --from=ghcr.io/astral-sh/uv:latest /uv /bin/

# set up the working directory inside the container
WORKDIR /code
ENV PATH="/code/.venv/bin:$PATH"

# Copy dependency files first (better layer caching)
COPY pyproject.toml .python-version uv.lock ./

# Install dependencies from lock file (ensures reproducible builds)
RUN uv sync --locked

# Copy application code into the container
COPY pipeline.py .

# Set entry point to run the pipeline script with uv
ENTRYPOINT ["python", "pipeline.py"]
