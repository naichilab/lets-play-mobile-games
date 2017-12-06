<template>
    <div class="row">
        <div class="col-xs-12 col-sm-12 col-md-4 col-lg-3">
            <h2>実況可否</h2>
            <div>
                <input type="radio" id="radPermissionAll" value="" v-model="formValues.permission" v-on:change="getGames">
                <label for="radPermissionAll">すべて</label>
            </div>
            <div>
                <input type="radio" id="radPermissionOK" value="true" v-model="formValues.permission" v-on:change="getGames">
                <label for="radPermissionOK">実況OK</label>
            </div>
            <div>
                <input type="radio" id="radPermissionNG" value="false" v-model="formValues.permission" v-on:change="getGames">
                <label for="radPermissionNG">実況NG</label>
            </div>
            <h2>プラットフォーム</h2>
            <div>
                <input type="radio" id="radPlatformAll" value="" v-model="formValues.platform" v-on:change="getGames">
                <label for="radPlatformAll">すべて</label>
            </div>
            <div>
                <input type="radio" id="radPlatformAndroid" value="android" v-model="formValues.platform" v-on:change="getGames">
                <label for="radPlatformAndroid">Android</label>
            </div>
            <div>
                <input type="radio" id="radPlatformIOS" value="ios" v-model="formValues.platform" v-on:change="getGames">
                <label for="radPlatformIOS">iOS</label>
            </div>
            <h2>ジャンル</h2>
            <div>
                <input type="radio" id="radCategoryAll" value="" v-model="formValues.category" v-on:change="getGames">
                <label for="radCategoryAll">すべて</label>
            </div>
            <div v-for="category in masterData.categories">
                <input type="radio" :id="'radCategory' + category.id" :value="category.id" v-model="formValues.category" v-on:change="getGames">
                <label :for="'radCategory' + category.id" v-text="category.name"></label>
            </div>
        </div>
        <div class="col-xs-12 col-sm-12 col-md-8 col-lg-9">
            <div v-if="games.length == 0">見つかりませんでした。</div>
            <div class="col-xs-12 col-sm-4 col-md-4 col-lg-3" v-for="game in games">

                <div class="boxed push-down-45">
                    <div class="meta">
                        <img class="game-icon-image" :src="game.icon.thumb.url">
                    </div>
                    <div class="row">
                        <div class="col-xs-10  col-xs-offset-1">

                            <!-- Start of the content -->
                            <div class="post-content--front-page">
                                <h1 class="front-page-title">
                                    <a href="/games/3" v-text="game.title"></a>
                                </h1>
                                <p>
                                    <span v-if="game.permission" class="label label-primary">実況OK</span>
                                    <span v-else="" class="label label-danger">実況NG</span>
                                </p>
                                <p>
                                    <span v-if="game.android_url != ''" class="label label-default">Android</span>
                                    <span v-if="game.ios_url != ''" class="label label-default">iOS</span>
                                </p>
                            </div>

                            <!-- End of the content -->
                            <a :href="'/games/' + game.id">
                                <div class="read-more">
                                    詳細
                                    <div class="read-more__arrow">
                                        <i class="fa fa-chevron-right"></i>
                                    </div>
                                </div>
                            </a></div>
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
                    permission: "",
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
<style scoped>
    .front-page-title {
        font-size: 1em;
    }
</style>