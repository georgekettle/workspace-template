const colors = require('tailwindcss/colors')

module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './config/initializers/**/*.rb',
    './app/javascript/**/*.js'
  ],
  theme: {
    colors: {
      transparent: 'transparent',
      current: 'currentColor',
      black: colors.black,
      white: colors.white,
      tertiary: colors.stone,
      success: colors.lime,
      danger: colors.red,
      info: colors.amber,
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
  ],
}
