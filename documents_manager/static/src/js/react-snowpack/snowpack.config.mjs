import proxy from "http2-proxy";

/** @type {import("snowpack").SnowpackUserConfig } */
export default {
  mount: {
    public: { url: "/", static: true },
    src: { url: "/dist" },
  },
  plugins: [
    "@snowpack/plugin-react-refresh",
    "@snowpack/plugin-dotenv",
    [
      "@snowpack/plugin-typescript",
      "@snowpack/plugin-webpack",
      {
        /* Yarn PnP workaround: see https://www.npmjs.com/package/@snowpack/plugin-typescript */
        ...(process.versions.pnp ? { tsc: "yarn pnpify tsc" } : {}),
      },
    ],
  ],
  alias: {
    "@": "./src",
  },
  routes: [
    /* Enable an SPA Fallback in development: */
    // {"match": "routes", "src": ".*", "dest": "/index.html"},
    {
      src: "/graphql/.*",
      dest: (req, res) => {
        // remove /api prefix (optional)
        // req.url = req.url.replace(/^/api/, '');

        return proxy.web(req, res, {
          hostname: "localhost",
          port: 8069,
        });
      },
    },
  ],
  optimize: {
    /* Example: Bundle your final build: */
    // "bundle": true,
    bundle: true,
    minify: true,
    target: "es2017",
  },
  packageOptions: {
    /* ... */
  },
  devOptions: {
    /* ... */
  },
  buildOptions: {
    /* ... */
  },
};
