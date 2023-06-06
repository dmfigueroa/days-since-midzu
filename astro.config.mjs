import { defineConfig } from "astro/config";

import cloudflare from "@astrojs/cloudflare";

import { loadEnv } from "vite";
const { CF_PAGES_URL, CF_PAGES, CF_PAGES_BRANCH, CUSTOM_DOMAIN } = loadEnv(
  import.meta.env.MODE,
  process.cwd(),
  ""
);

const getSite = () => {
  if (CUSTOM_DOMAIN) {
    return CUSTOM_DOMAIN;
  } else if (CF_PAGES && !["master", "main"].includes(CF_PAGES_BRANCH)) {
    return CF_PAGES_URL;
  } else {
    return "http://localhost:8788";
  }
};

// https://astro.build/config
export default defineConfig({
  output: "server",
  adapter: cloudflare({ mode: "directory" }),
  site: getSite(),
});
