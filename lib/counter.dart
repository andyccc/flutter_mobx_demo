import 'package:mobx/mobx.dart';


/**
 *
 *
 *
    1. 执行命令: flutter packages pub run build_runner build
    2. 删除之内再生成: flutter packages pub run build_runner build --delete-conflicting-outputs
    3. 实时更新.g文件: flutter packages pub run build_runner watch

 * */

// This is our generated file (we'll see this soon!)
part 'counter.g.dart';

// We expose this to be used throughout our project
class Counter = _Counter with _$Counter;

// Our store class
abstract class _Counter with Store {
  @observable
  int value = 1;

  @computed
  int get cvalue => value;


  @action
  void increment() {
    value++;
  }

  @action
  void decrement() {
    value--;
  }
}