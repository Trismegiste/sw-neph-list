<detail-kabbale>
    <article if="{model !== undefined }">
        <header>
            <h1>{model.Sort}</h1>
            <div  class="pure-g">
                <div class="pure-u-1-3">
                    <img src="./img/mdk.svg"/>
                </div>
                <div class="pure-u-1-3">
                    <img src="./img/sephirah.svg"/>
                </div>
                <div class="pure-u-1-3">
                    <img src="./img/elem/{model.Element.toLowerCase()}.svg"/>
                </div>
                <div class="pure-u-1-3">
                    <h2>{model.Monde}</h2>
                </div>
                <div class="pure-u-1-3">
                    <h2>{model.Sephirah}</h2>
                </div>
                <div class="pure-u-1-3">
                        <h2>{model.Element}</h2>
                </div>
            </div>
            <div  class="pure-g">
                <div class="pure-u-1-3">
                    <h3>INI</h3>
                    d{ convertKa(model.Ka).dice }
                    <virtual each="{ convertKa(model.Ka).puce }"><i class="icon-circle dotted-icon"></i></virtual>
                </div>
                <div class="pure-u-1-3">
                    <h3>Portée</h3>
                    {model['Portée']}
                </div>
                <div class="pure-u-1-3">
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
        this.kabbaleList = nephData.get('kabbale')
        var self = this

        convertKa(ka) {
            var dotted = [];
            for (var k = 0; k < ((ka - 1) % 5); k++) {
                dotted.push(true)
            }

            return {
                dice: Math.floor((ka - 1) / 5) * 2 + 4,
                puce: dotted
            }
        }

        var subRoute = riot.route.create()
        subRoute('/kabbale/*', function (pk) {
            self.parent.activeTab = 'detail-kabbale'
            self.model = self.kabbaleList[pk]
            self.parent.update()
        })
    </script>
</detail-kabbale>