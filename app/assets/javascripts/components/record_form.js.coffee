@RecordForm = React.createClass
  # A clean form
  getInitialState: ->
    title: ''
    date: ''
    amount: ''
  # update state as the form is changing at every keystroke
  handleChange: (e) ->
    name = e.target.name
    @setState "#{ name }": e.target.value
  # POST the form
  handleSubmit: (e) ->
    e.preventDefault()
    $.post '/records', {record: @state}, (data) =>
      @props.handleNewRecord data
      @setState @getInitialState()
    , 'JSON'
  #validate the form (just see if something is entered or not)
  valid: ->
    @state.title && @state.date && @state.amount
  # Render it
  render: ->
    React.DOM.form
      className: 'form-inline'
      onSubmit: @handleSubmit
      React.DOM.div
        className: 'form-group'
        React.DOM.input
          type: 'text'
          className: 'form-control'
          placeholder: 'Date'
          name: 'date'
          value: @state.date
          onChange: @handleChange
      React.DOM.div
        className: 'form-group'
        React.DOM.input
          type: 'text'
          className: 'form-control'
          placeholder: 'Title'
          name: 'title'
          value: @state.title
          onChange: @handleChange
      React.DOM.div
        className: 'form-group'
        React.DOM.input
          type: 'number'
          className: 'form-control'
          placeholder: 'Amount'
          name: 'amount'
          value: @state.amount
          onChange: @handleChange
      React.DOM.button
        type: 'submit'
        className: 'btn btn-primary'
        disabled: !@valid()
        'Create record'
