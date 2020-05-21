# Docker NGINX Proxy with Caching


## Purging Cache

```bash
curl -X PURGE -D - "https://www.example.com/*"
```

## Notes:

Won't work if the upstream updates cookies each time - e.g. when using XDebug (a dev image) upstream.

Shouldn't cache content when users are logged in.

## Maintainer

This repository is maintained by [Black Pear Digital](https://www.blackpeardigital.co.uk).
