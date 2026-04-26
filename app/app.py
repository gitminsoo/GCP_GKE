import os
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer


class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        app_name = os.getenv("APP_NAME", "Fortune Web App")
        app_env = os.getenv("APP_ENV", "development")
        app_version = os.getenv("APP_VERSION", "1.0")

        body = (
            f"{app_name}\n"
            f"environment={app_env}\n"
            f"version={app_version}\n"
            "status=ok\n"
        ).encode("utf-8")

        self.send_response(200)
        self.send_header("Content-Type", "text/plain; charset=utf-8")
        self.send_header("Content-Length", str(len(body)))
        self.end_headers()
        self.wfile.write(body)


if __name__ == "__main__":
    server = ThreadingHTTPServer(("0.0.0.0", 8080), Handler)
    server.serve_forever()

