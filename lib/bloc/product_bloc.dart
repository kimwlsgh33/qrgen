import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos/repository/license_repository.dart';
import 'package:todos/repository/product_repository.dart';

//================================================================================================
// Bloc - Map Event to State
//================================================================================================
class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository _productRepository;
  final LicenseRepository _licenseRepository;

  // constructor - inject repository & initial state
  ProductBloc(
    this._productRepository,
    this._licenseRepository,
  ) : super(InitProductState()) {
    on<DefaultLoadProductEvent>(_defaultLoadProduct);
    on<PayLoadProductEvent>(_payLoadProduct);
    add(DefaultLoadProductEvent()); // initial event
    add(PayLoadProductEvent(false));
    // subscribe to LicenseRepository.stream ( license status )
    _licenseRepository.stream.listen((event) {
      add(PayLoadProductEvent(event));
    });
  }

  _defaultLoadProduct(
      DefaultLoadProductEvent event, Emitter<ProductState> emit) async {
    // 로딩중
    emit(LoadingProductState(
      defaultItems: state.defaultItems,
      payItems: state.payItems,
    ));
    var result = await _productRepository.loadDefaultProduct();
    // 로딩완료
    emit(LoadedProductState(
      defaultItems: result,
      payItems: state.payItems,
    ));
  }

  _payLoadProduct(PayLoadProductEvent event, Emitter<ProductState> emit) async {
    emit(LoadingProductState(
      defaultItems: state.defaultItems,
      payItems: state.payItems,
    ));
    var result = await _productRepository.loadPayProduct(event.hasLicense);
    emit(LoadedProductState(
      defaultItems: state.defaultItems,
      payItems: result,
    ));
  }

  // Bloc을 사용하는 결정적인 이유.
  @override
  void onChange(Change<ProductState> change) {
    // TODO: implement onChange
    super.onChange(change);
  }

  @override
  void onTransition(Transition<ProductEvent, ProductState> transition) {
    // TODO: implement onTransition
    super.onTransition(transition);
  }
}

//================================================================================================
// Event - UI
//================================================================================================

abstract class ProductEvent extends Equatable {}

class DefaultLoadProductEvent extends ProductEvent {
  @override
  List<Object?> get props => [];
}

class PayLoadProductEvent extends ProductEvent {
  final bool hasLicense;
  PayLoadProductEvent(this.hasLicense);
  @override
  List<Object?> get props => [];
}

//================================================================================================
// State
//================================================================================================
abstract class ProductState extends Equatable {
  final List<String>? defaultItems;
  final List<String>? payItems;
  const ProductState({
    this.defaultItems,
    this.payItems,
  });
}

class InitProductState extends ProductState {
  InitProductState() : super(defaultItems: [], payItems: []);
  @override
  List<Object?> get props => [defaultItems, payItems];
}

class LoadingProductState extends ProductState {
  const LoadingProductState({
    super.defaultItems,
    super.payItems,
  });
  @override
  List<Object?> get props => [defaultItems, payItems];
}

class LoadedProductState extends ProductState {
  const LoadedProductState({
    super.defaultItems,
    super.payItems,
  });
  @override
  List<Object?> get props => [defaultItems, payItems];
}

class ErrorProductState extends ProductState {
  final String message;
  const ErrorProductState(this.message);
  @override
  List<Object> get props => [];
}

    // ================================================================================
    // Event switch & use concurency
    // ================================================================================
    // on<ProductEvent>((event, emit) async{
    //   if (event is DefaultLoadProductEvent) {
    //     await _defaultLoadProduct(event, emit);
    //   }
    //   if (event is PayLoadProductEvent) {
    //     await _payLoadProduct(event, emit);
    //   }
    // }, transformer: sequential());
