// See the Tailwind configuration guide for advanced usage
// https://tailwindcss.com/docs/configuration
module.exports = {
  content: ["./js/**/*.js", "../lib/*_web.ex", "../lib/*_web/**/*.*ex"],
  safelist: ["bg-ttc-500/25", "bg-go-500/25"],
  theme: {
    extend: {
      colors: {
        ttc: {
          100: "#ff9474",
          200: "#ff7a5e",
          300: "#ff6048",
          400: "#f84532",
          500: "#da251d",
          600: "#bd0007",
          700: "#a00000",
          800: "#840000",
          900: "#6a0000",
        },
        go: {
          100: "#97cb8f",
          200: "#7fb277",
          300: "#679a61",
          400: "#50824b",
          500: "#3a6b36",
          600: "#245522",
          700: "#0b400e",
          800: "#002b00",
          900: "#001b00",
        },
      },
    },
  },
  plugins: [require("@tailwindcss/forms")],
};
