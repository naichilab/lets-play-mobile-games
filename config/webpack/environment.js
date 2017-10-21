const { environment } = require('@rails/webpacker')

module.exports = environment

environment.loaders.get('vue').options.extractCSS = false