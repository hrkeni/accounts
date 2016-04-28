@Record = React.createClass
  getInitialState: ->
    edit: false
  render: ->
    if @state.edit
      @recordForm()
    else
      @recordRow()
  # render a record row (read-only)
  recordRow: ->
    React.DOM.tr null,
      React.DOM.td null, @props.record.date
      React.DOM.td null, @props.record.title
      React.DOM.td null, amountFormat(@props.record.amount)
      React.DOM.td null,
        React.DOM.a
          className: 'btn btn-default'
          onClick: @handleToggle
          'Edit'
        React.DOM.a
          className: 'btn btn-danger'
          onClick: @handleDelete
          'Delete'
  # render a record form for editing
  recordForm: ->
    React.DOM.tr null,
      React.DOM.td null,
        React.DOM.input
          className: 'form-control'
          type: 'text'
          defaultValue: @props.record.date
          ref: 'date'
      React.DOM.td null,
        React.DOM.input
          className: 'form-control'
          type: 'text'
          defaultValue: @props.record.title
          ref: 'title'
      React.DOM.td null,
        React.DOM.input
          className: 'form-control'
          type: 'number'
          defaultValue: @props.record.amount
          ref: 'amount'
      React.DOM.td null,
        React.DOM.a
          className: 'btn btn-default'
          onClick: @handleEdit
          'Update'
        React.DOM.a
          className: 'btn btn-danger'
          onClick: @handleToggle
          'Cancel'
  # delete a record
  handleDelete: (e) ->
    e.preventDefault()
    $.ajax
      method: 'DELETE'
      url: "/records/#{@props.record.id}"
      dataType: 'JSON'
      success: () =>
        @props.handleDeleteRecord @props.record
  # toggle in/out of edit mode for this record
  handleToggle: (e) ->
    e.preventDefault()
    @setState edit: !@state.edit
  # ajax request for edit
  handleEdit: (e) ->
    e.preventDefault()
    data =
      title: ReactDOM.findDOMNode(@refs.title).value
      date: ReactDOM.findDOMNode(@refs.date).value
      amount: ReactDOM.findDOMNode(@refs.amount).value
    $.ajax
      method: 'PUT'
      url: "/records/#{@props.record.id}"
      dataType: 'JSON'
      data:
        record: data
      success: (data) =>
        @setState edit: false
        @props.handleEditRecord @props.record, data
