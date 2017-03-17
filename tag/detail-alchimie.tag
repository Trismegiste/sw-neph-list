<detail-alchimie>
    <article>
        <header>
            <h1>{model.Sort}</h1>
            <div  class="pure-g">
                <div class="pure-u-1-3">
                    <svg width="2.6em" height="2.6em">
                    <circle cx="1.3em" cy="1.3em" r="1.1em" stroke="black" stroke-width="3" fill="white" />
                    </svg>
                </div>
                <div class="pure-u-1-3">
                    <img if="{model.Substance != undefined }" src="./img/{model.Substance.toLowerCase()}.svg"/>
                </div>
                <div class="pure-u-1-3">
                    <img if="{model.Element != undefined }" src="./img/{model.Element.toLowerCase()}.svg"/>
                </div>
                <div class="pure-u-1-3">
                    <h2>{model.Cercle}</h2>
                </div>
                <div class="pure-u-1-3">
                    <h2>{model.Substance}</h2>
                </div>
                <div class="pure-u-1-3">
                    <h2>{model.Element}</h2>
                </div>
            </div>
            <div  class="pure-g">
                <div class="pure-u-1-2">
                    <h3>Portée</h3>
                    {model['Portée']}
                </div>
                <div class="pure-u-1-2">
                    <h3>Durée</h3>
                    {model['Durée']}
                </div>
            </div>
        </header>
        <section>{model.Effet}</section>
        <section>{model.Aspect}</section>
        <footer>page {model.Page}</footer>
    </article>
    <script>
        this.listing = nephData.get('alchimie')
        this.model = {}
        var self = this

        var subRoute = riot.route.create()
        subRoute('/alchimie/*', function (pk) {
            self.parent.activeTab = 'detail-alchimie'
            self.model = self.listing[pk]
            self.parent.update()
        })
    </script>
</detail-alchimie>