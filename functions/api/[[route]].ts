import { Hono } from "hono";
import { handle } from "hono/cloudflare-pages";

const app = new Hono().basePath("/api");

app.get("/health", (c) => {
  return c.json({ status: "ok" });
});

export const onRequest = handle(app);
