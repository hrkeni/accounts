@Records = React.createClass
  getInitialState: ->
    records: @props.data
  getDefaultProps: ->
    records: []
  # update view when record is added
  addRecord: (record) ->
    records = React.addons.update(@state.records, { $push: [record] })
    @setState records: records
  # update view when record is deleted
  deleteRecord: (record) ->
    index = records.indexOf record
    records = React.addons.update(@state.records, { $splice: [[index, 1]] })
    @replaceState records: records
  # update view after a record is updated
  updateRecord: (record, data) ->
    index = @state.records.indexOf record
    records = React.addons.update(@state.records, { $splice: [[index, 1, data]]  })
    @replaceState records: records
  # render it
  render: ->
    React.DOM.div
      className: 'records'
      React.DOM.h2
        className: 'title'
        'Records'
      React.DOM.div
        className: 'row'
        React.createElement AmountBox, type: 'success', amount: @credits(), text: 'Credits' # render a box for credits
        React.createElement AmountBox, type: 'danger', amount: @debits(), text: 'Debits' # render a box for debits
        React.createElement AmountBox, type: 'info', amount: @balance(), text: 'Balance' # render a box for balance
      React.createElement RecordForm, handleNewRecord: @addRecord
      React.DOM.hr null
      React.DOM.table
        className: 'table table-bordered'
        React.DOM.thead null,
          React.DOM.tr null,
            React.DOM.th null, 'Date'
            React.DOM.th null, 'Title'
            React.DOM.th null, 'Amount'
            React.DOM.th null, 'Actions'
        React.DOM.tbody null,
          for record in @state.records
            React.createElement Record, key: record.id, record: record, handleDeleteRecord: @deleteRecord, handleEditRecord: @updateRecord
  # calculate total credits
  credits: ->
    credits = @state.records.filter (val) -> val.amount >= 0
    credits.reduce ((prev, curr) ->
      prev + parseFloat(curr.amount)
    ), 0
  # calculate total debits
  debits: ->
    debits = @state.records.filter (val) -> val.amount < 0
    debits.reduce ((prev, curr) ->
      prev + parseFloat(curr.amount)
    ), 0
  # calculate balance
  balance: ->
    @debits() + @credits()
