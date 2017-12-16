<template>
    <div class="row">
        <div class="col-xs-12 col-sm-12 col-md-4 col-lg-3">
            <!-- TODO: サーバサイド実装後に対応 -->
            <div class="input-group search-area">
                <input class="form-control" type="text"  placeholder="ゲームタイトルで探す" />
                <span class="input-group-btn">
                    <button class="btn btn-primary" type="button"><i class="fa fa-search" aria-hidden="true"></i></button>
                </span>
            </div>

            <input type="checkbox" id="filtering" class="hidden-element condition-filter-area">
            <label for="filtering" class="btn btn-warning btn-block condition-filter-area filter-btn">
                <i class="fa fa-filter"></i>条件で絞りこみ
            </label>

            <div class="condition-area">
                <div class="panel panel-default condition-box box-joint">
                    <div class="panel-heading search-condition-title" data-toggle="collapse" data-target="#platform-condition" aria-expanded="true" aria-controls="platform-chevron">
                        <i class="fa fa-caret-right" aria-hidden="true"></i>
                        <i class="fa fa-caret-down" aria-hidden="true"></i>
                        プラットフォーム
                    </div>
                    <ul class="list-group collapse in" id="platform-condition">
                        <li class="condition-item">
                            <input type="radio" id="radPlatformAll" value="" v-model="formValues.platform" v-on:change="getGames">
                            <label for="radPlatformAll">すべて</label>
                        </li>
                        <li class="condition-item">
                            <input type="radio" id="radPlatformAndroid" value="android" v-model="formValues.platform"
                                                                                        v-on:change="getGames">
                            <label for="radPlatformAndroid">
                                <span class="icon-android" aria-hidden="true"></span>Android
                            </label>
                        </li>
                        <li class="condition-item">
                            <input type="radio" id="radPlatformIOS" value="ios" v-model="formValues.platform"
                                                                                v-on:change="getGames">
                            <label for="radPlatformIOS">
                                <span class="icon-ios" aria-hidden="true"></span>iOS
                            </label>
                        </li>
                    </ul>
                </div>

                <div class="panel panel-default condition-box">
                    <div class="panel-heading search-condition-title" data-toggle="collapse" data-target="#genre-condition" aria-expanded="true" aria-controls="genre-chevron">
                        <i class="fa fa-caret-right" aria-hidden="true"></i>
                        <i class="fa fa-caret-down" aria-hidden="true"></i>
                        ジャンル
                    </div>
                    <ul class="list-group collapse in" id="genre-condition">
                        <li class="condition-item">
                            <input type="radio" id="radCategoryAll" value="" v-model="formValues.category" v-on:change="getGames">
                            <label for="radCategoryAll">すべて</label>
                        </li>
                        <li class="condition-item" v-for="category in masterData.categories">
                            <input type="radio" :id="'radCategory' + category.id" :value="category.id" v-model="formValues.category"
                                                                                                       v-on:change="getGames">
                            <label :for="'radCategory' + category.id" v-text="category.name"></label>
                        </li>
                    </ul>
                </div>
            </div>
        </div>

        <div class="col-xs-12 col-sm-12 col-md-8 col-lg-9">
            <div v-if="games.length === 0">
                <h3>見つかりませんでした。</h3>
                <p>このサービスに登録されていないゲームについては、開発者に直接お問い合わせください。</p>
            </div>
            <div class="col-xs-12 col-sm-4 col-md-4 col-lg-3" v-for="game in games">
                <!-- Start of the content -->
                <div class="boxed">
                    <div class="boxed-content">
                        <a :href="'/games/' + game.id"></a>
                        <img class="game-icon-image" :src="game.icon.thumb.url">
                        <div class="front-page-title ellipsisable-text">
                            <span v-text="game.title"></span>
                        </div>
                        <div class="boxed-icon-area">
                            <span class="icon-guideline" v-if="game.guideline !== null && game.guideline.length > 0 " aria-hidden="true"></span>
                            <span class="icon-android" v-if="game.android_url.length > 0" aria-hidden="true"></span>
                            <span class="icon-ios" v-if="game.ios_url.length > 0" aria-hidden="true"></span>
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
                games: {},
                masterData: {
                    categories: {}
                },
                formValues: {
                    category: "",
                    platform: ""
                }
            }
        },
        created: function () {
            axios.get('/api/categories')
                .then(res => {
                    this.masterData.categories = res.data
                })
            axios.get('/api/games')
                .then(res => {
                    this.games = res.data;
                })
        },
        methods: {
            getGames() {
                axios.get('/api/games'
                    , {params: this.formValues})
                    .then(res => {
                        this.games = res.data;
                    })
            }
        },
    }
</script>
