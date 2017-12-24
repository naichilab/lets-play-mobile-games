/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

// ref. https://qiita.com/midnightSuyama/items/efc5441a577f3d3abe74
// Vue読み込み方
// 1. 使いたいページのviewで、 data-vue="hogehoge" といったタグをつける
// 2. packs/options/hogehoge.js を用意する
//    * dataやmethods等を書いておく
// たぶんこんなかんじ

console.log('Hello World from Webpacker')


import Vue from 'vue/dist/vue.esm'
import VueDataScooper from "vue-data-scooper"

Vue.use(VueDataScooper)

var vms = []

var options = {}
var requireContext = require.context('./options', false, /\.js$/)
requireContext.keys().forEach(key => {
    let name = key.split('/').pop().split('.').shift()
    options[name] = requireContext(key).default
})

document.addEventListener('turbolinks:load', () => {
    let templates = document.querySelectorAll('[data-vue]')
    for (let el of templates) {
        let vm = new Vue(
            Object.assign(options[el.dataset.vue], {el})
        )
        vms.push(vm)
    }
})

document.addEventListener('turbolinks:visit', () => {
    for (let vm of vms) {
        vm.$destroy()
    }
    vms = []
})