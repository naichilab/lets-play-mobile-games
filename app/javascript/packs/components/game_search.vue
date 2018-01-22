<template>
    <div class="row">
        <div class="col-12 col-sm-12 col-md-4 col-lg-3">

            <div class="input-group search-area">
                <input class="form-control" type="text" placeholder="単語で探す" v-model="formValues.words"
                       v-on:change="getGames"/>
                <span class="input-group-btn">
                    <button class="btn btn-primary" type="button" v-on:click="getGames"><i class="fa fa-search"
                                                                                           aria-hidden="true"></i></button>
                </span>
            </div>

            <input type="checkbox" id="filtering" class="hidden-element condition-filter-area">
            <label for="filtering" class="btn btn-warning btn-block condition-filter-area filter-btn">
                <i class="fa fa-filter"></i>条件で絞りこみ
            </label>

            <div class="condition-area">
                <div class="panel panel-default condition-box box-joint">
                    <div class="panel-heading search-condition-title" data-toggle="collapse"
                         data-target="#platform-condition" aria-expanded="true" aria-controls="platform-chevron">
                        <i class="fa fa-caret-right" aria-hidden="true"></i>
                        <i class="fa fa-caret-down" aria-hidden="true"></i>
                        プラットフォーム
                    </div>
                    <ul class="list-group collapse in" id="platform-condition">
                        <li class="condition-item">
                            <input type="radio" id="radPlatformAll" value="" v-model="formValues.platform"
                                   v-on:change="getGames">
                            <label for="radPlatformAll">すべて</label>
                        </li>
                        <li class="condition-item" v-for="p in masterData.platforms">
                            <input type="radio" :id="'radPlatform' + p.code" :value="p.code"
                                   v-model="formValues.platform"
                                   @change="getGames">
                            <label :for="'radPlatform' + p.code">
                                <span :class="'icon-' + p.code" aria-hidden="true"></span>{{p.name}}
                            </label>
                        </li>
                    </ul>
                </div>

                <div class="panel panel-default condition-box">
                    <div class="panel-heading search-condition-title" data-toggle="collapse"
                         data-target="#genre-condition" aria-expanded="true" aria-controls="genre-chevron">
                        <i class="fa fa-caret-right" aria-hidden="true"></i>
                        <i class="fa fa-caret-down" aria-hidden="true"></i>
                        ジャンル
                    </div>
                    <ul class="list-group collapse in" id="genre-condition">
                        <li class="condition-item">
                            <input type="radio" id="radCategoryAll" value="" v-model="formValues.category"
                                   v-on:change="getGames">
                            <label for="radCategoryAll">すべて</label>
                        </li>
                        <li class="condition-item" v-for="category in masterData.categories">
                            <input type="radio" :id="'radCategory' + category.id" :value="category.id"
                                   v-model="formValues.category"
                                   v-on:change="getGames">
                            <label :for="'radCategory' + category.id" v-text="category.name"></label>
                        </li>
                    </ul>
                </div>
            </div>
        </div>

        <div class="col-12 col-sm-12 col-md-8 col-lg-9">
            <div v-if="orderdGames.length === 0">
                <h3>見つかりませんでした。</h3>
                <p>このサービスに登録されていないゲームについては、開発者に直接お問い合わせください。</p>
            </div>
            <div class="row">
                <div class="col-12 col-sm-4 col-md-4 col-lg-3" v-for="game in orderdGames">
                    <!-- Start of the content -->
                    <div class="boxed">
                        <div class="boxed-content">
                            <a :href="'/games/' + game.id"></a>
                            <img class="game-icon-image" :src="game.icon.thumb.url">
                            <div class="front-page-title ellipsisable-text">
                                <span v-text="game.title"></span>
                            </div>
                            <div class="boxed-icon-area">
                                <span class="icon-guideline" v-if="game.guideline !== null && game.guideline.length > 0 "
                                                             aria-hidden="true"></span>
                                <span :class="'platform-icon icon-' + p.code" v-for="p in masterData.platforms"
                                                                              v-if="game['has_' + p.code]" aria-hidden="true" v-bind:tooltip="p.name"></span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>
<script>
    import axios from 'axios';

    export default {
        props: ['msg'],
        data: function () {
            return {
                games: [],
                masterData: {
                    categories: {},
                    platforms: {}
                },
                formValues: {
                    words: "",
                    category: "",
                    platform: ""
                }
            }
        },
        computed: {
            orderdGames: function () {
                return this.games.sort(function (a, b) {
                    if (a.created_at > b.created_at) return -1
                    if (a.created_at < b.created_at) return 1
                    return 0
                })
            }
        },
        created: function () {
            axios.get('/api/categories')
                .then(res => {
                    this.masterData.categories = res.data.categories
                })
            axios.get('/api/platforms')
                .then(res => {
                    console.log("get platforms")
                    this.masterData.platforms = res.data.platforms
                })
            axios.get('/api/games')
                .then(res => {
                    this.games = res.data.games;
                })
        },
        methods: {
            getGames() {
                axios.get('/api/games'
                    , {params: this.formValues})
                    .then(res => {
                        this.games = res.data.games;
                    })
            }
        },
    }
</script>
