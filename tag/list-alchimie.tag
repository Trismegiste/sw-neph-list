<list-alchimie>
    <form class="pure-form" onsubmit="{
                noSubmit
            }">
        <div class="pure-g">
            <div class="pure-u-2-3">
                <input type="text" name="keyword" placeholder="Texte à chercher" class="pure-input-1" onkeyup="{
                            onSearch
                        }"/>
            </div>
            <div class="pure-u-1-3">
                <a class="pure-button pure-input-1" onclick="{
                            onShowConfig
                        }">
                    Config
                    <i class="icon-down-open" if="{ !configVisible }"></i>
                    <i class="icon-up-open" if="{ configVisible }"></i>
                </a>
            </div>
        </div>
        <section class="laboratory" if="{ configVisible }">
            <div class="pure-g">
                <div class="pure-u-1-5" each="{ substance in laboratoire }">
                    <i class="icon-{substance.toLowerCase()} {disabled: !config.outil[substance]}"
                       onclick="{
                                   parent.onClickOutil
                               }"></i>
                </div>
            </div>
            <div class="pure-g " each="{ ka in element }">
                <div class="pure-u-1-5" each="{ substance in laboratoire }">
                    <i class="icon-{ka} {disabled: !config.substance[substance][ka]}"
                       data-element="{ka}"
                       onclick="{
                                   parent.parent.onClickSubstance
                               }"></i>
                </div>
            </div>
            <div class="pure-g">
                <div class="pure-u-1-5" each="{ title in nephData.alliage }">
                    <i class="icon-{title} {disabled: !config.alliage[title]}"
                       onclick="{
                                   onClickAlliage
                               }"></i>
                </div>
            </div>
        </section>
    </form>

    <table class="pure-table pure-table-striped listing">
        <tbody>
            <tr each="{row, idx in found}" onclick="{
                        parent.onDetail
                    }">
                <td class="xl-visible"><i class="icon-{nephData.extractAlchemyIcon(row)}"></i></td>
                <td class="xl-visible"><i class="icon-{row.Substance.toLowerCase()}"></i></td>
                <td><i class="icon-{row.Element.toLowerCase()}"></i></td>
                <td>{row.Sort}</td>
                <td class="xl-visible">{row.Effet}</td>
                <td class="xl-visible">{row["Portée"]}</td>
                <td class="xl-visible">{row["Durée"]}</td>
                <td class="printer-only"></td>
                <td class="printer-only"></td>
            </tr>
        </tbody>
        <tfoot if="{ found.length }"><tr><td colspan="9">{ found.length } formules</td></tr></tfoot>
    </table>

    <script>
        this.listing = nephData.get('alchimie')
        this.laboratoire = nephData.laboratoire
        this.found = []
        this.element = nephData.element
        var self = this
        // client config
        this.config = myConfig.read('alchimie-config', {
            outil: {},
            substance: {
                Liqueur: {},
                'Métal': {},
                'Vapeur': {},
                'Poudre': {},
                'Ambre': {}
            },
            alliage: {}
        })
        this.configVisible = false

        this.onShowConfig = function () {
            self.configVisible = !self.configVisible
        }

        this.noSubmit = function () {
            // to make the virtual keyboard disappeard on mobile
            self.keyword.blur()
            self.trigger('search')
        }

        this.onClickOutil = function (e) {
            var k = e.item.substance
            self.config.outil[k] = !self.config.outil[k]
            if (!self.config.outil[k]) {
                self.config.substance[k] = {}
                var mnt = nephData.getAlliageForSubstance(k)
                self.config.alliage[mnt] = false
            }
            myConfig.write('alchimie-config', self.config)
            self.trigger('search')
        }

        this.onClickSubstance = function (e) {
            var s = e.item.substance
            var k = e.target.dataset.element
            if (self.config.outil[s]) {
                self.config.substance[s][k] = !self.config.substance[s][k]
            }
            myConfig.write('alchimie-config', self.config)
            self.trigger('search')
        }

        this.onClickAlliage = function (e) {
            var k = e.item.title
            var s = nephData.getSubstanceForAlliage(k)
            if (self.config.outil[s]) {
                self.config.alliage[k] = !self.config.alliage[k]
            }
            myConfig.write('alchimie-config', self.config)
            self.trigger('search')
        }

        this.on('search', function () {
            self.found = nephData.findSubstance(self.keyword.value, self.config)
            nephData.sortSubstance(self.found)
        })

        this.onSearch = function () {
            self.trigger('search')
        }

        this.onDetail = function (e) {
            riot.route('alchimie/' + e.item.row.pk)
        }

    </script>
</list-alchimie>