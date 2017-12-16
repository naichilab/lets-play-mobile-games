<template>

    <form action="/games" method="post" class="form-horizontal">
        {{ game }}
        <br>
        {{ categories }}
        <br>
        {{ formValues }}
        <legend>新規作成</legend>

        <fieldset>
            <!-- title -->
            <div class="form-group">
                <label for="game_title" class="col-lg-3 control-label">タイトル</label>
                <div class="col-lg-9">
                    <input id="game_title" type="text" class="form-control" placeholder="ゲームタイトル"
                           v-model="formValues.title">
                </div>
            </div>

            <!-- category -->
            <div class="form-group">
                <label for="game_category" class="col-lg-3 control-label">ジャンル</label>
                <div class="col-lg-9">
                    <select id="game_category" class="form-control" v-model="formValues.category">
                        <option value="">選択してください</option>
                        <option v-for="category in categories" :value="category.id" v-text="category.name"></option>
                    </select>
                </div>
            </div>

            <!-- guideline -->
            <div class="form-group">
                <label for="game_guideline" class="col-lg-3 control-label">ガイドライン</label>
                <div class="col-lg-9">
                    <textarea id="game_guideline" class="form-control" rows="5" placeholder="実況に関するガイドライン、もしくはガイドラインを記載したURLがあれば入力してください。特にない場合は何も記入しないでください。" v-model="formValues.guideline"></textarea>
                </div>
            </div>

            <!-- specific_condition -->
            <div class="form-group">
                <label for="game_specific_conditions" class="col-lg-3 control-label">実況者へ伝えたいこと</label>
                <div class="col-lg-9">
                    <textarea id="game_specific_conditions" class="form-control" rows="3" placeholder="ゲームの楽しみ方など、実況者へ伝えたいことがあれば入力してください。" v-model="formValues.specific_conditions"></textarea>
                </div>
            </div>

            <!-- icon -->
            <div class="form-group">
                <label for="game_icon" class="col-lg-3 control-label">アイコン画像</label>
                <div class="col-lg-9">
                    <input id="game_icon" class="form-control" type="file" v-on:change="iconSelectedChanged">
                    <span class="help-block">正方形を推奨。正方形に切り取られて表示されます。</span>
                </div>
            </div>

        </fieldset>
    </form>

</template>
<script>
    import axios from 'axios';

    export default {
        props: ['game','categories'],
        data: function () {
            return {
                games: {},
                masterData: {
                    categories: {}
                },
                formValues: {
                    title: "",
                    permission: "",
                    category: "",
                    platform: "",
                    guideline: "",
                    specific_conditions: "",
                    icon: "",
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
            iconSelectedChanged() {
                console.log("iconSelectedChanged")
                //選択されたFileの情報を保存しておく
                e.preventDefault()
                let files = e.target.files
                this.formValues.uploadFile
                this.formValues.icon = files[0]
            },
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

    .post-content--front-page {
        margin-bottom: 0;
    }
</style>