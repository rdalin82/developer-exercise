$(document).ready(function () {
  // model
  var Quote = Backbone.Model.extend({
    defaults: {
      source: '',
      context: '',
      quote: '',
      theme: ', '
    }
  })
  // collection
  var Quotes = Backbone.Collection.extend({
    model: Quote,
    url: 'https://gist.githubusercontent.com/anonymous/8f61a8733ed7fa41c4ea/raw/1e90fd2741bb6310582e3822f59927eb535f6c73/quotes.json',
    parse: function (data) {
      return data
    }
  })
  // app view
  var AppView = Backbone.View.extend({
    el: '#container',
    initialize: function () {
      this.render()
    },
    events: {
      'click #forward': 'nextQuotes',
      'click #backward': 'prevQuotes'
    },
    render: function () {
      this.$el.html('<h1>Game and Movie Quotes</h1>')
      this.$el.append('<div id="backward"><a> &larr; Backward</a></div><div id="forward"><a>Forward &rarr;</a></div>')
      // populating quotes
      this.quotes = this.getQuotes()
      this.start = 0
      this.stop = 15
      this.quoteTemplate = _.template($('#quote-template').html())
      this.pagesTemplate = _.template("<div id='page-range'><h2><%= start %> to <%= stop %> out of 38</h2></div>")
      this.displayQuotes(this.quotes, this.start, this.stop, this.quoteTemplate)
    },
    getQuotes: function () {
      var quotes = new Quotes()
      return quotes
    },
    displayQuotes: function (quotes, start, stop, template) {
      quotes.fetch({
        success: function (data) {
          var response = data.toJSON()
          for (var i = start; i < stop; i++) {
            $('#quotes tbody').append(template(response[i]))
          }
        }
      })
      $('#page-range').remove()
      this.$el.append(this.pagesTemplate({start: this.start + 1, stop: this.stop }))
    },
    nextQuotes: function () {
      var quotes = this.quotes
      var pagination = 15
      if (this.start + pagination > quotes.length) return
      this.clearQuotes()
      if (this.stop + pagination < quotes.length) {
        this.start = this.start + pagination
        this.stop = this.stop + pagination
        this.displayQuotes(quotes, this.start, this.stop, this.quoteTemplate)
      } else {
        this.start = this.start + pagination
        this.stop = quotes.length
        this.displayQuotes(quotes, this.start, this.stop, this.quoteTemplate)
      }
    },
    prevQuotes: function (quotes) {
      quotes = this.quotes
      var pagination = 15
      if (this.start - 1 < 0) return
      this.clearQuotes()
      if (this.start - 15 >= 0) {
        this.start = this.start - pagination
        this.stop = this.start + pagination
        this.displayQuotes(quotes, this.start, this.stop, this.quoteTemplate)
      } else {
        this.start = 0
        this.stop = this.stop - pagination
        this.displayQuotes(quotes, this.start, this.stop, this.quoteTemplate)
      }
    },
    clearQuotes: function () {
      $('tr td').parent().remove()
    }
  })
  // initialize application
  appView = new AppView()
})
