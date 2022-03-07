import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../providers/products.dart';

class EditProuductScreen extends StatefulWidget {
  const EditProuductScreen({Key? key}) : super(key: key);

  static const routName = "/edit-product";

  @override
  _EditProuductScreenState createState() => _EditProuductScreenState();
}

class _EditProuductScreenState extends State<EditProuductScreen> {
  final _form = GlobalKey<FormState>();
  final _imageForm = GlobalKey<FormState>();

  var _product = Product(
    id: '',
    title: '',
    imageUrl: '',
    argument: '',
    price: 0.0,
    isNew: false,
    sale: 0,
    backgroundcolora: 255,
    backgroundcolorr: 255,
    backgroundcolorg: 193,
    backgroundcolorb: 7,
  );

  final _priceFocus = FocusNode();
  final _descriptionFocus = FocusNode();
  final _saleFocus = FocusNode();

  var _hasImage = true;
  var _init = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (_init) {
      final productId = ModalRoute.of(context)!.settings.arguments;
      if (productId != null) {
        final _editingProduct =
            Provider.of<Products>(context).findById(productId as String);
        _product = _editingProduct;
      }
    }

    _init = false;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _priceFocus.dispose();
    _descriptionFocus.dispose();
    _saleFocus.dispose();
  }

  Color _selectedColor = Colors.amber;
  Color _pickerColor = Colors.amber;

  void _showImageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Rasm linkini kiriting!'),
          content: Form(
            key: _imageForm,
            child: TextFormField(
              initialValue: _product.imageUrl,
              decoration: const InputDecoration(
                labelText: 'Rasm URL',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.url,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Iltimos, rasm URL kiriting';
                } else if (!value.startsWith('http')) {
                  return 'Iltimos, to\'g\'ri rasm URL kiriting';
                }
              },
              onSaved: (newValue) {
                _product = Product(
                  id: _product.id,
                  title: _product.title,
                  imageUrl: newValue!,
                  argument: _product.argument,
                  price: _product.price,
                  isNew: _product.isNew,
                  sale: _product.sale,
                  backgroundcolora: _product.backgroundcolora,
                  backgroundcolorr: _product.backgroundcolorr,
                  backgroundcolorg: _product.backgroundcolorg,
                  backgroundcolorb: _product.backgroundcolorb,
                  isFavorite: _product.isFavorite,
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('BEKOR QILISH'),
            ),
            ElevatedButton(
              onPressed: _saveImageForm,
              child: const Text('SAQLASH'),
            ),
          ],
        );
      },
    );
  }

  void _saveImageForm() {
    final _isValid = _imageForm.currentState!.validate();
    if (_isValid) {
      _imageForm.currentState!.save();
      Navigator.of(context).pop();
      setState(() {
        _hasImage = true;
      });
    }
  }

  Future<void> _saveForm() async {
    FocusScope.of(context).unfocus();
    final isValid = _form.currentState!.validate();
    setState(() {
      _hasImage = _product.imageUrl.isNotEmpty;
    });
    if (isValid && _hasImage) {
      _form.currentState!.save();
      if (_product.id.isEmpty) {
        setState(() {
          _isLoading = true;
        });
        try {
          await Provider.of<Products>(context, listen: false)
              .addProduct(_product);
        } catch (error) {
          await showDialog<Null>(
              context: context,
              builder: (ctx) {
                return AlertDialog(
                  title: const Text("Xatolik sodir bo'ldi"),
                  content:
                      const Text("Maxsulot qo'shishda xatolik sodir bo'ldi"),
                  actions: [
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text("Okay"),
                    ),
                  ],
                );
              });
        }
      } else {
        await Provider.of<Products>(context, listen: false)
            .updateProduct(_product);
      }
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: _product.id.isEmpty
            ? const Text("Mahsulotni qo'shish")
            : const Text("Mahsulotni tahrirlash"),
        actions: [
          IconButton(
            onPressed: _saveForm,
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Form(
                key: _form,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      TextFormField(
                        initialValue: _product.title,
                        decoration: const InputDecoration(
                          labelText: 'Nomi',
                          border: OutlineInputBorder(),
                        ),
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_descriptionFocus);
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Iltimos, mahsulot nomini kiriting!';
                          } else if (value.length < 3) {
                            return 'Mahsulot nomi 3ta harfdan uzunroq bo\'lishi kerak';
                          }
                        },
                        onSaved: (newValue) {
                          _product = Product(
                            id: _product.id,
                            title: newValue!,
                            imageUrl: _product.imageUrl,
                            argument: _product.argument,
                            price: _product.price,
                            isNew: _product.isNew,
                            sale: _product.sale,
                            backgroundcolora: _product.backgroundcolora,
                            backgroundcolorr: _product.backgroundcolorr,
                            backgroundcolorg: _product.backgroundcolorg,
                            backgroundcolorb: _product.backgroundcolorb,
                            isFavorite: _product.isFavorite,
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        initialValue: _product.argument,
                        decoration: const InputDecoration(
                          labelText: 'Qo\'shimcha ma\'lumot',
                          border: OutlineInputBorder(),
                          alignLabelWithHint: true,
                        ),
                        maxLines: 5,
                        focusNode: _descriptionFocus,
                        keyboardType: TextInputType.multiline,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Iltimos, tavsifini kiriting!';
                          } else if (value.length < 10) {
                            return 'Mahsulot tavsifi 10ta harfdan uzunroq bo\'lishi kerak';
                          }
                        },
                        onSaved: (newValue) {
                          _product = Product(
                            id: _product.id,
                            title: _product.title,
                            imageUrl: _product.imageUrl,
                            argument: newValue!,
                            price: _product.price,
                            isNew: _product.isNew,
                            sale: _product.sale,
                            backgroundcolora: _product.backgroundcolora,
                            backgroundcolorr: _product.backgroundcolorr,
                            backgroundcolorg: _product.backgroundcolorg,
                            backgroundcolorb: _product.backgroundcolorb,
                            isFavorite: _product.isFavorite,
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        initialValue: _product.price == 0
                            ? ''
                            : _product.price.toString(),
                        decoration: const InputDecoration(
                          labelText: 'Narxi',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        focusNode: _priceFocus,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_saleFocus);
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Iltimos, mahsulot narxini kiriting!';
                          } else if (double.tryParse(value) == null) {
                            return 'Baraka topgur dasturchilarni qiynamanglar unaqa ¯\\_(ツ)_/¯';
                          } else if (double.parse(value) < 1) {
                            return 'Mahsulot narxi 0dan katta bo\'lishi kerak';
                          }
                        },
                        onSaved: (newValue) {
                          _product = Product(
                            id: _product.id,
                            title: _product.title,
                            imageUrl: _product.imageUrl,
                            argument: _product.argument,
                            price: double.parse(newValue!),
                            isNew: _product.isNew,
                            sale: _product.sale,
                            backgroundcolora: _product.backgroundcolora,
                            backgroundcolorr: _product.backgroundcolorr,
                            backgroundcolorg: _product.backgroundcolorg,
                            backgroundcolorb: _product.backgroundcolorb,
                            isFavorite: _product.isFavorite,
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        initialValue:
                            _product.sale == 0 ? '' : _product.sale.toString(),
                        decoration: const InputDecoration(
                          labelText: 'Chegirma %',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        focusNode: _saleFocus,
                        onSaved: (newValue) {
                          _product = Product(
                            id: _product.id,
                            title: _product.title,
                            imageUrl: _product.imageUrl,
                            argument: _product.argument,
                            price: _product.price,
                            isNew: _product.isNew,
                            sale: newValue!.isEmpty ? 0 : int.parse(newValue),
                            backgroundcolora: _product.backgroundcolora,
                            backgroundcolorr: _product.backgroundcolorr,
                            backgroundcolorg: _product.backgroundcolorg,
                            backgroundcolorb: _product.backgroundcolorb,
                            isFavorite: _product.isFavorite,
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Text('Mahsulot yangimi: '),
                          Checkbox(
                            value: _product.isNew,
                            onChanged: (_) {
                              setState(
                                () {
                                  _product = Product(
                                    id: _product.id,
                                    title: _product.title,
                                    imageUrl: _product.imageUrl,
                                    argument: _product.argument,
                                    price: _product.price,
                                    isNew: !_product.isNew,
                                    sale: _product.sale,
                                    backgroundcolora: _product.backgroundcolora,
                                    backgroundcolorr: _product.backgroundcolorr,
                                    backgroundcolorg: _product.backgroundcolorg,
                                    backgroundcolorb: _product.backgroundcolorb,
                                    isFavorite: _product.isFavorite,
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Text('Orqa fon rangini tanlang:'),
                          InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (ctx) {
                                  return AlertDialog(
                                    content: SingleChildScrollView(
                                      child: ColorPicker(
                                        pickerColor: _selectedColor,
                                        onColorChanged: (Color color) {
                                          setState(() => _pickerColor = color);
                                        },
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          setState(
                                            () {
                                              _selectedColor = _pickerColor;

                                              print(_pickerColor);
                                              _product = Product(
                                                id: _product.id,
                                                title: _product.title,
                                                imageUrl: _product.imageUrl,
                                                argument: _product.argument,
                                                price: _product.price,
                                                isNew: _product.isNew,
                                                sale: _product.sale,
                                                backgroundcolora:
                                                    _selectedColor.alpha,
                                                backgroundcolorr:
                                                    _selectedColor.red,
                                                backgroundcolorg:
                                                    _selectedColor.green,
                                                backgroundcolorb:
                                                    _selectedColor.blue,
                                                isFavorite: _product.isFavorite,
                                              );
                                            },
                                          );
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text(
                                          'Tayyor',
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.only(left: 5),
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 3,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                                border: Border.all(
                                  color: Colors.white,
                                  width: 3,
                                ),
                                color: Color.fromARGB(
                                    _product.backgroundcolora,
                                    _product.backgroundcolorr,
                                    _product.backgroundcolorg,
                                    _product.backgroundcolorb),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Card(
                        margin: const EdgeInsets.all(0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          side: BorderSide(
                            color: _hasImage
                                ? Colors.grey
                                : Theme.of(context).errorColor,
                          ),
                        ),
                        child: InkWell(
                          onTap: () => _showImageDialog(context),
                          borderRadius: BorderRadius.circular(5),
                          splashColor:
                              Theme.of(context).primaryColor.withOpacity(0.5),
                          highlightColor: Colors.transparent,
                          child: Container(
                            height: 250,
                            width: double.infinity,
                            alignment: Alignment.center,
                            child: _product.imageUrl.isEmpty
                                ? Text(
                                    'Asosiy rasm linkini qo\'ying (png formatda)!',
                                    style: TextStyle(
                                      color: !_hasImage
                                          ? Theme.of(context).errorColor
                                          : Colors.black,
                                    ),
                                  )
                                : Image.network(
                                    _product.imageUrl,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
