<detail-magie class="detail pure-g">
    <div class="pure-u-xl-1-3"></div>
    <div class="pure-u-1 pure-u-xl-1-3">
        <article>
            <header>
                <h1>Le mage {model["verbe"].toLowerCase()}</h1>
                <div  class="pure-g big-icon">
                    <div class="pure-u-1-2">
                        <i class="icon-{getVerbe(model['Cercle'])}"></i>
                        <h2>{getVerbe(model['Cercle'])}</h2>
                    </div>
                    <div class="pure-u-1-2">
                        <i class="icon-{model['Élément'].toLowerCase()}"></i>
                        <h2>{model['Élément']}</h2>
                    </div>
                    <div class="pure-u-1">
                        <h2 each="{possib in explodeChaine(model['Chaîne']) }">{possib}</h2>
                    </div>
                    <div class="pure-u-1">
                        <h3>Portée</h3>
                        {model['Cible']}
                    </div>
                </div>
            </header>
            <section>{model["effet"]}</section>
        </article>
    </div>
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

        this.getVerbe = function (n) {
            return ['', 'percevoir', 'manipuler', 'maîtriser'][n]
        }
    </script>
</detail-magie>