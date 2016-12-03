<detail-magie>
    <article>
        <header>
            <h2>{model.Sort}</h2>
            <div  class="pure-g">
                <div class="pure-u-1-2">La mage {model["Le mage…"].toLowerCase()}</div>
                <div class="pure-u-1-2">{model['Chaîne']}</div>
                <div class="pure-u-1-2">{model['Élément']}</div>
                <div class="pure-u-1-2">{model['Cible']}</div>
            </div>
        </header>
        <section>{model["Effet (avec Relance)"]}</section>
    </article>
    <script>
        this.listing = nephData.get('magie')
        this.model = {}
        var self = this

        var subRoute = riot.route.create()
        subRoute('/magie/*', function (pk) {
            self.parent.activeTab = 'detail-magie'
            self.model = self.listing[pk]
            self.parent.update()
        })
    </script>
</detail-magie>