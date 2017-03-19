<detail-magie class="detail">
    <article>
        <header>
            <h1>Le mage {model["Le mage…"].toLowerCase()}</h1>
            <div  class="pure-g big-icon">
                <div class="pure-u-1-3">
                    <i class="icon-{model['Élément'].toLowerCase()}"></i>
                    <h2>{model['Élément']}</h2>
                </div>
                <div class="pure-u-2-3">
                    <h2 each="{possib in explodeChaine(model['Chaîne']) }">{possib}</h2>
                </div>
                <div class="pure-u-1">
                    <h3>Portée</h3>
                    {model['Cible']}
                </div>
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

        this.explodeChaine = function (str) {
            return str.split("\n")
        }
    </script>
</detail-magie>