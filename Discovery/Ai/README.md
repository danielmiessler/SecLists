# AI discovery wordlists

## ai-api-endpoints.txt

Use for: Discovering REST API endpoints exposed by AI service providers and frameworks.

Source: https://github.com/openai/openai-openapi/blob/master/openapi.yaml

Source: https://github.com/ollama/ollama/blob/main/docs/api.md

Source: https://github.com/weaviate/weaviate/blob/master/openapi-specs/schema.json

Source: https://github.com/a2aproject/A2A/blob/main/docs/specification.md

> Note: API versioning and routing prefixes (`api/`, `v1/`, `v2/`, etc.) are intentionally omitted. Users should prepend whichever base path their target exposes.

> Note: A2A entries include Google API Design Guide custom methods with `:action` suffixes (e.g. `tasks/{id}:cancel`).