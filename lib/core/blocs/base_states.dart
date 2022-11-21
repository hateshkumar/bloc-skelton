class ReliableBaseState {
  final bool initializing;
  final bool primaryBusy;
  final bool secondaryBusy;
  final bool tertiaryBusy;
  final bool idle;
  final bool error;
  final bool empty;
  final dynamic data;

  ReliableBaseState({
    bool initializing = false,
    bool busy = false,
    bool idle = false,
    bool error = false,
    bool empty = false,
    bool secondaryBusy = false,
    bool tertiaryBusy = false,
    dynamic data = dynamic,
  })  : this.initializing = initializing,
        this.primaryBusy = busy,
        this.idle = idle,
        this.error = error,
        this.empty = empty,
        this.secondaryBusy = secondaryBusy,
        this.tertiaryBusy = tertiaryBusy,
        this.data = data;

  ReliableBaseState.initializing() : this(initializing: true);

  ReliableBaseState.primaryBusy() : this(busy: true);

  ReliableBaseState.idle() : this(idle: true);

  ReliableBaseState.error() : this(error: true);

  ReliableBaseState.empty() : this(empty: true);

  ReliableBaseState.secondaryBusy() : this(secondaryBusy: true);

  ReliableBaseState.tertiaryBusy() : this(tertiaryBusy: true);

  ReliableBaseState.response(data) : this(data: data);
}
