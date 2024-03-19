part of 'design_cubit.dart';

abstract class DesignState {}

class DesignInitialLoaing extends DesignState {}

class DesignInitialSuccess extends DesignState {}

class DesignInitialError extends DesignState {}

final class DesignInitial extends DesignState {}

class DesignModelSelected extends DesignState {
  final int selectedModel;

  DesignModelSelected(this.selectedModel);
}

class DesignModelSelectedEdit extends DesignState {
  final String text;

  DesignModelSelectedEdit(this.text);
}

final class DesignInitialSuccesDesign extends DesignState {}

class DesignInitialServerLoaing extends DesignState {}

class DesignInitialServerSuccess extends DesignState {}

class DesignInitialServerError extends DesignState {}
