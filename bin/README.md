# Test task solution

## Prerequisites

Please ensure that `docker` and `docker-compose` are available in your system.


## One-click launch

```bash
bin/run-all.sh
```

## Examples

Get result as defined in test task description

```bash
curl --request GET \
  --url http://localhost:5000/by-query
```
```bash
curl --request GET \
  --url http://localhost:5000/by-orm
```

Response

```json
{
  "avg":12,
  "figure":"http://localhost:5000/files/fig-b175377c-711e-434d-9dbf-89f234b8ba4d.png",
  "ok":true,
}
```