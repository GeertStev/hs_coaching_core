import 'dart:async';

/// A minimal `switchMap`: for each event from this stream, subscribes to
/// `mapper`'s returned stream, cancelling the previous inner subscription
/// first. Used wherever a live sub-stream must track only the *latest* outer
/// id (e.g. "current image/text" documents) — plain `asyncExpand`/`asyncMap`
/// either buffer/serialize instead of switching, or do a one-shot fetch that
/// misses later edits to the same document.
extension SwitchMap<T> on Stream<T> {
  Stream<R> switchMap<R>(Stream<R> Function(T event) mapper) {
    late StreamController<R> controller;
    StreamSubscription<T>? outerSub;
    StreamSubscription<R>? innerSub;

    controller = StreamController<R>.broadcast(
      onListen: () {
        outerSub = listen(
          (event) {
            innerSub?.cancel();
            innerSub = mapper(
              event,
            ).listen(controller.add, onError: controller.addError);
          },
          onError: controller.addError,
          onDone: controller.close,
        );
      },
      onCancel: () {
        innerSub?.cancel();
        outerSub?.cancel();
      },
    );
    return controller.stream;
  }
}
