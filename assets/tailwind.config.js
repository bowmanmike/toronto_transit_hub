// See the Tailwind configuration guide for advanced usage
// https://tailwindcss.com/docs/configuration
module.exports = {
  content: ["./js/**/*.js", "../lib/*_web.ex", "../lib/*_web/**/*.*ex"],
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
      },
    },
  },
  plugins: [require("@tailwindcss/forms")],
};
