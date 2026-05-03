#  Instructions for Data-Engineering-workshop Pipeline

## Project Overview
- This project is a minimal data pipeline, primarily using Python 3.13+ and pandas/pyarrow for data processing.
- The main workflow is containerized using Docker and leverages the `uv` tool for dependency management and reproducible builds.
- The core logic is in `pipeline/pipeline.py`, which processes a month argument, generates a DataFrame, and writes a Parquet file.

## Key Components
- **pipeline/pipeline.py**: Main script. Expects a single integer argument (month), creates a DataFrame, and outputs `output_{month}.parquet`.
- **pipeline/main.py**: Simple entrypoint for local testing (prints a hello message).
- **pipeline/pyproject.toml**: Declares dependencies (`pandas`, `pyarrow`) and project metadata.
- **pipeline/uv.lock**: Lockfile for reproducible dependency installs (used by `uv`).
- **pipeline/Dockerfile**: Multi-stage build. Uses `uv` for dependency sync, sets up `/code` as workdir, and runs `pipeline.py` as entrypoint.

## Developer Workflows
- **Build Docker image:**
  ```sh
  docker build -t pipeline .
  ```
- **Run pipeline in Docker:**
  ```sh
  docker run --rm pipeline 12
  ```
  (Replace `12` with desired month integer)
- **Local run (for development):**
  ```sh
  python pipeline/pipeline.py 12
  ```
- **Dependency management:**
  - Use `uv sync --locked` to install dependencies from `uv.lock`.
  - Python version must be >=3.13 (see `.python-version`).

## Conventions & Patterns
- All data outputs are written as Parquet files named `output_{month}.parquet` in the working directory.
- Arguments are passed positionally to `pipeline.py` (no CLI framework).
- No test automation or CI/CD is present; add as needed.
- No custom environment variable handling; all config is via arguments or code.

## Integration Points
- Docker is the canonical execution environment; local runs should match Docker as closely as possible.
- No external services or APIs are integrated.

## Examples
- See `pipeline/pipeline.py` for the expected data flow and output format.
- See `pipeline/Dockerfile` for the build and run process.
