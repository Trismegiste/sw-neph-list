<detail-kabbale>
    <article>
        <header>
            <h2>{model.Sort}</h2>
            <div  class="pure-g">
                <div class="pure-u-1-3">{model.Sephirah}</div>
                <div class="pure-u-1-3">{model.Monde}</div>
                <div class="pure-u-1-3">{model.Element}</div>
                <div class="pure-u-1-3">
                    INI: d{ convertKa(model.Ka).dice }
                    <virtual each="{ convertKa(model.Ka).puce }">&ofcir;</virtual>
                </div>
                <div class="pure-u-1-3">{model['Portée']}</div>
                <div class="pure-u-1-3">{model['Durée']}</div>
            </div>
        </header>
        <section>{model.Effet}</section>
        <section>{model.Aspect}</section>
        <footer>page {model.Page}</footer>
    </article>
    <script>
        this.kabbaleList = nephData.get('kabbale')
        this.model = {}
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