<spa>
    <nav class="pure-menu pure-menu-horizontal top-menu">
        <ul class="pure-menu-list">
            <li each="{tab, i in menuTab}"
                class="pure-menu-item {pure-menu-selected: parent.isActiveTab(tab.ref)}">
                <a href="#{tab.ref}" class="pure-menu-link">
                    <i class="{ tab.title }"></i>
                </a>
            </li>
        </ul>
    </nav>
    <div class="pure-g">
        <div class="pure-u-1-1 {hidden: !isActiveTab('magie')}">
            <list-magie></list-magie>
        </div>
        <div class="pure-u-1-1 {hidden: !isActiveTab('kabbale')}">
            <list-kabbale></list-kabbale>
        </div>
        <div class="pure-u-1-1 {hidden: !isActiveTab('alchimie')}">
            <list-alchimie></list-alchimie>
        </div>
    </div>
    <script>
        this.menuTab = [
            {ref: 'magie', title: 'icon-heka'},
            {ref: 'kabbale', title: 'icon-kabbale'},
            {ref: 'alchimie', title: 'icon-alchimie'}
        ]
        this.activeTab = 'kabbale'

        isActiveTab(ref) {
            return ref === this.activeTab
        }

        // this to hide waiting spinner
        this.on('mount', function() {
            document.getElementById('waiting').remove()
            document.getElementById('mainapp').className = ''
        })

        var subRoute = riot.route.create()
        var self = this
        this.menuTab.forEach(function(tab) {
            subRoute('/' + tab.ref, function() {
                self.activeTab = tab.ref
                self.update()
            })
        })
    </script>
</spa>