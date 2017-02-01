
grammar thetuparser;

@parser::preinclude {	
	#include<string.h>
}

@parser::members {
#define ATT_Strg 1
#define ATT_Name 2
#define ATT_Chain 3
#define ATT_Link 4
#define ATT_Lngt 5 
#define ATT_Srcp 6
#define ATT_Bitfield 8
#define ATT_Type 9
#define ATT_Note 10
#define ATT_Body 11
#define ATT_Lang 12
#define ATT_Size 13
#define ATT_Mngl 14
#define ATT_Integer_value 15
#define ATT_Valu 16
#define ATT_Retn 17
#define ATT_Prms 18
#define ATT_Sign 19
#define ATT_Min 20
#define ATT_Max 21
#define ATT_Opr 22
#define ATT_Tag 23
#define ATT_Unql 24
#define ATT_Scpe 25
#define ATT_Clas 26
#define ATT_Chan 27
#define ATT_Orig 28
#define ATT_Accs 29
#define ATT_Bpos 30
#define ATT_Vfld 31
#define ATT_Binf 32
#define ATT_Argt 33
#define ATT_Labl 34
#define ATT_Line 35
#define ATT_Expr 36
#define ATT_Qual 37
#define ATT_Cls 38
#define ATT_Dcls 39
#define ATT_Rslt 40 
#define ATT_Used 41
#define ATT_Algn 42
#define ATT_Args 43
#define ATT_Ptd 44
#define ATT_Int 45
#define ATT_Prec 46
#define ATT_Vars 47
#define ATT_Fn 48
#define ATT_Init 49
#define ATT_Flds 50
#define ATT_Fncs 51
#define ATT_Bases 52
#define ATT_Base 53
#define ATT_Spec 54
#define ATT_Tmpl 56
#define ATT_Minus_token 57
#define ATT_Purp 58
#define ATT_Elts 59
#define ATT_Domn 60
#define ATT_Bfld 61
#define ATT_Crnt 62
#define ATT_Inst 63
#define ATT_Cond 64
#define ATT_Spcs 65
#define ATT_Refd 66
#define ATT_Then 67
#define ATT_Cnst 68
#define ATT_Else 69
#define ATT_Csts 70
#define ATT_Parm 71
#define ATT_Hdlr 72
#define ATT_Clnp 73
#define ATT_Decl 74
#define ATT_New 75
#define ATT_Ctor 76
#define ATT_Val 77
#define ATT_Idx 78
#define ATT_Low 79

	struct node_attr{
		int type;
		std::string value;
	};

	struct gcc_tu_node{
		std::string index;
		std::string node_name;
		std::vector <struct node_attr *> attributes;
	};
	typedef struct gcc_tu_node node;

	std::vector <node*> root_list;
}

translation_unit returns [std::vector <node*> root_list]
:
	rules {
		root_list = $rules.vec_reg_node;
		std::cout << "Number of registers: " << root_list.size() << std::endl;
		$root_list = root_list;
	}
	| EOF { $root_list = root_list; }
;

rules returns [std::vector <node*> vec_reg_node]
:
	(
		{node* reg_node; reg_node=new node;}
		unique_identifier node_name (attributes 
									{reg_node->attributes = $attributes.root_attr_vec;}
									)? 
		{
			reg_node->node_name = $node_name.text;
			reg_node->index = $unique_identifier.text;
			$vec_reg_node.push_back(reg_node);
		}
	)+
		{
			
		}
;

unique_identifier:
	Unique_id
;

node_name:
	Identifier 
	| Identifier 
	| Constructor
	| Destructor
	| Static_assert
;

attributes returns [std::vector <struct node_attr *> root_attr_vec]
@init {
	std::vector <struct node_attr *> attributes_vector;
}:
	(attribute {attributes_vector.push_back($attribute.attr);})+

;

attribute returns [struct node_attr * attr]
@init{
	std::string strgvalues="";
}:
	Strg  Colon (strg_value {strgvalues += $strg_value.text;})* {
		$attr = new struct node_attr;
		$attr->value = strgvalues; $attr->type = ATT_Strg;
	}
	| Name  Colon name_value{
		$attr = new struct node_attr;
		$attr->value = $name_value.text; $attr->type = ATT_Name;
	}
	| Chain Colon chain_value{
		$attr = new struct node_attr;
		$attr->value = $chain_value.text; $attr->type = ATT_Chain;
	}
	| Link  Colon link_value{
		$attr = new struct node_attr;
		$attr->value = $link_value.text; $attr->type = ATT_Link;
	}
	| Lngt  Colon lngt_value{
		$attr = new struct node_attr;
		$attr->value = $lngt_value.text; $attr->type = ATT_Lngt;
	}
	| Srcp  Colon srcp_value{
		$attr = new struct node_attr;
		$attr->value = $srcp_value.text; $attr->type = ATT_Srcp;
	}
	| Srcp  Colon {}
	| Bitfield {}
	| Type  Colon type_value {
		$attr = new struct node_attr;
		$attr->value = $type_value.text; $attr->type = ATT_Type;
	}
	| Note  Colon note_value{
		$attr = new struct node_attr;
		$attr->value = $note_value.text; $attr->type = ATT_Note;
	}
	| Body  Colon body_value{
		$attr = new struct node_attr;
		$attr->value = $body_value.text; $attr->type = ATT_Body;
	}
	| Lang  Colon lang_value{
		$attr = new struct node_attr;
		$attr->value = $lang_value.text; $attr->type = ATT_Lang;
	}
	| Size  Colon size_value{
		$attr = new struct node_attr;
		$attr->value = $size_value.text; $attr->type = ATT_Size;
	}
	| Mngl  Colon mngl_value{
		$attr = new struct node_attr;
		$attr->value = $mngl_value.text; $attr->type = ATT_Mngl;
	}
	| Integer_value Colon Unique_id{}
	| Valu Colon valu_value{
		$attr = new struct node_attr;
		$attr->value = $valu_value.text; $attr->type = ATT_Valu;
	}
	| Retn Colon retn_value{
		$attr = new struct node_attr;
		$attr->value = $retn_value.text; $attr->type = ATT_Retn;
	}
	| Prms Colon prms_value{
		$attr = new struct node_attr;
		$attr->value = $prms_value.text; $attr->type = ATT_Prms;
	}
	| Sign Colon sign_value{
		$attr = new struct node_attr;
		$attr->value = $sign_value.text; $attr->type = ATT_Sign;
	}
	| Min Colon min_value{
		$attr = new struct node_attr;
		$attr->value = $min_value.text; $attr->type = ATT_Min;
	}
	| Max Colon max_value{
		$attr = new struct node_attr;
		$attr->value = $max_value.text; $attr->type = ATT_Max;
	}
	| Opr Integer_value Colon opr_value{
		$attr = new struct node_attr;
		$attr->value = $opr_value.text; $attr->type = ATT_Opr;
	}
	| Tag Colon tag_value{
		$attr = new struct node_attr;
		$attr->value = $tag_value.text; $attr->type = ATT_Tag;
	}
	| Unql Colon unql_value{
		$attr = new struct node_attr;
		$attr->value = $unql_value.text; $attr->type = ATT_Unql;
	}
	| Scpe Colon scpe_value{
		$attr = new struct node_attr;
		$attr->value = $scpe_value.text; $attr->type = ATT_Scpe;
	}
	| Clas Colon clas_value{
		$attr = new struct node_attr;
		$attr->value = $clas_value.text; $attr->type = ATT_Clas;
	}
	| Chan Colon chan_value{
		$attr = new struct node_attr;
		$attr->value = $chan_value.text; $attr->type = ATT_Chan;
	}
	| Orig Colon orig_value{
		$attr = new struct node_attr;
		$attr->value = $orig_value.text; $attr->type = ATT_Orig;
	}
	| Accs Colon accs_value{
		$attr = new struct node_attr;
		$attr->value = $accs_value.text; $attr->type = ATT_Accs;
	}
	| Bpos Colon bpos_value{
		$attr = new struct node_attr;
		$attr->value = $bpos_value.text; $attr->type = ATT_Bpos;
	}
	| Vfld Colon vfld_value{
		$attr = new struct node_attr;
		$attr->value = $vfld_value.text; $attr->type = ATT_Vfld;
	}
	| Binf Colon binf_value{
		$attr = new struct node_attr;
		$attr->value = $binf_value.text; $attr->type = ATT_Binf;
	}
	| Argt Colon argt_value{
		$attr = new struct node_attr;
		$attr->value = $argt_value.text; $attr->type = ATT_Argt;
	}
	| Labl Colon labl_value{
		$attr = new struct node_attr;
		$attr->value = $labl_value.text; $attr->type = ATT_Labl;
	}
	| Line Colon line_value{
		$attr = new struct node_attr;
		$attr->value = $line_value.text; $attr->type = ATT_Line;
	}
	| Expr Colon expr_value{
		$attr = new struct node_attr;
		$attr->value = $expr_value.text; $attr->type = ATT_Expr;
	}
	| Qual Colon qual_value{
		$attr = new struct node_attr;
		$attr->value = $qual_value.text; $attr->type = ATT_Qual;
	}
	| Cls Colon cls_value{
		$attr = new struct node_attr;
		$attr->value = $cls_value.text; $attr->type = ATT_Cls;
	}
	| Dcls Colon dcls_value{
		$attr = new struct node_attr;
		$attr->value = $dcls_value.text; $attr->type = ATT_Dcls;
	}
	| Rslt Colon rslt_value{
		$attr = new struct node_attr;
		$attr->value = $rslt_value.text; $attr->type = ATT_Rslt;
	}
	| Used Colon used_value{
		$attr = new struct node_attr;
		$attr->value = $used_value.text; $attr->type = ATT_Used;
	}
	| Algn Colon algn_value{
		$attr = new struct node_attr;
		$attr->value = $algn_value.text; $attr->type = ATT_Algn;
	}
	| Args Colon args_value{
		$attr = new struct node_attr;
		$attr->value = $args_value.text; $attr->type = ATT_Args;
	}
	| Ptd Colon ptd_value{
		$attr = new struct node_attr;
		$attr->value = $ptd_value.text; $attr->type = ATT_Ptd;
	}
	| Int Colon int_value{
		$attr = new struct node_attr;
		$attr->value = $int_value.text; $attr->type = ATT_Int;
	}
	| Prec Colon prec_value{
		$attr = new struct node_attr;
		$attr->value = $prec_value.text; $attr->type = ATT_Prec;
	}
	| Vars Colon vars_value{
		$attr = new struct node_attr;
		$attr->value = $vars_value.text; $attr->type = ATT_Vars;
	}
	| Fn Colon fn_value{
		$attr = new struct node_attr;
		$attr->value = $fn_value.text; $attr->type = ATT_Fn;
	}
	| Fn
	| Init Colon init_value{
		$attr = new struct node_attr;
		$attr->value = $init_value.text; $attr->type = ATT_Init;
	}
	| Flds Colon flds_value{
		$attr = new struct node_attr;
		$attr->value = $flds_value.text; $attr->type = ATT_Flds;
	}
	| Fncs Colon fncs_value{
		$attr = new struct node_attr;
		$attr->value = $fncs_value.text; $attr->type = ATT_Fncs;
	}
	| Bases Colon bases_value{
		$attr = new struct node_attr;
		$attr->value = $bases_value.text; $attr->type = ATT_Bases;
	}
	| Base Colon base_value{
		$attr = new struct node_attr;
		$attr->value = $base_value.text; $attr->type = ATT_Base;
	}
	| Spec Colon spec_value{
		$attr = new struct node_attr;
		$attr->value = $spec_value.text; $attr->type = ATT_Spec;
	}
	| Spec
	| Tmpl
	| Minus_token
	| Purp Colon purp_value{
		$attr = new struct node_attr;
		$attr->value = $purp_value.text; $attr->type = ATT_Purp;
	}
	| Elts Colon elts_value{
		$attr = new struct node_attr;
		$attr->value = $elts_value.text; $attr->type = ATT_Elts;
	}
	| Domn Colon domn_value{
		$attr = new struct node_attr;
		$attr->value = $domn_value.text; $attr->type = ATT_Domn;
	}
	| Bfld Colon bfld_value{
		$attr = new struct node_attr;
		$attr->value = $bfld_value.text; $attr->type = ATT_Bfld;
	}
	| Crnt Colon crnt_value{
		$attr = new struct node_attr;
		$attr->value = $crnt_value.text; $attr->type = ATT_Crnt;
	}
	| Inst Colon inst_value{
		$attr = new struct node_attr;
		$attr->value = $inst_value.text; $attr->type = ATT_Inst;
	}
	| Cond Colon cond_value{
		$attr = new struct node_attr;
		$attr->value = $cond_value.text; $attr->type = ATT_Cond;
	}
	| Spcs Colon spcs_value{
		$attr = new struct node_attr;
		$attr->value = $spcs_value.text; $attr->type = ATT_Spcs;
	}
	| Refd Colon refd_value{
		$attr = new struct node_attr;
		$attr->value = $refd_value.text; $attr->type = ATT_Refd;
	}
	| Then Colon then_value{
		$attr = new struct node_attr;
		$attr->value = $then_value.text; $attr->type = ATT_Then;
	}
	| Cnst Colon cnst_value{
		$attr = new struct node_attr;
		$attr->value = $cnst_value.text; $attr->type = ATT_Cnst;
	}
	| Else Colon else_value{
		$attr = new struct node_attr;
		$attr->value = $else_value.text; $attr->type = ATT_Else;
	}
	| Csts Colon csts_value{
		$attr = new struct node_attr;
		$attr->value = $csts_value.text; $attr->type = ATT_Csts;
	}
	| Parm Colon parm_value{
		$attr = new struct node_attr;
		$attr->value = $parm_value.text; $attr->type = ATT_Parm;
	}
	| Hdlr Colon hdlr_value{
		$attr = new struct node_attr;
		$attr->value = $hdlr_value.text; $attr->type = ATT_Hdlr;
	}
	| Clnp Colon clnp_value{
		$attr = new struct node_attr;
		$attr->value = $clnp_value.text; $attr->type = ATT_Clnp;
	}
	| Decl Colon decl_value{
		$attr = new struct node_attr;
		$attr->value = $decl_value.text; $attr->type = ATT_Decl;
	}
	| New Colon new_value{
		$attr = new struct node_attr;
		$attr->value = $new_value.text; $attr->type = ATT_New;
	}
	| Ctor Colon ctor_value{
		$attr = new struct node_attr;
		$attr->value = $ctor_value.text; $attr->type = ATT_Ctor;
	}
	| Val Colon val_value{
		$attr = new struct node_attr;
		$attr->value = $val_value.text; $attr->type = ATT_Val;
	}
	| Idx Colon idx_value{
		$attr = new struct node_attr;
		$attr->value = $idx_value.text; $attr->type = ATT_Idx;
	}
	| Low Colon low_value{
		$attr = new struct node_attr;
		$attr->value = $low_value.text; $attr->type = ATT_Low;
	}
;

low_value:
	Unique_id
;

idx_value:
	Unique_id
;

val_value:
	Unique_id
;

ctor_value:
	Integer_value
;

new_value:
	Integer_value
;

decl_value:
	Unique_id
;

clnp_value:
	Unique_id
;

hdlr_value:
	Unique_id
;

parm_value:
	Unique_id
;

csts_value:
	Unique_id
;

else_value:
	Unique_id
;

cnst_value:
	Unique_id
;

then_value:
	Unique_id
;

refd_value:
	Unique_id
;

spcs_value:
	Unique_id
;

cond_value:
	Unique_id
;

inst_value:
	Unique_id
;

crnt_value:
	Unique_id
;

bfld_value:
	Unique_id
;

domn_value:
	Unique_id
;

elts_value:
	Unique_id
;

purp_value:
	Unique_id
;

spec_value:
	Identifier
	| Mutable
;


bases_value:
	Integer_value
;	

base_value:
	Unique_id
;	

fncs_value:
	Unique_id
;

flds_value:
	Unique_id
;

init_value
:
	Unique_id
;

fn_value:
	Unique_id
;

vars_value
:
	Unique_id
;

prec_value:
	Integer_value
;

int_value:
	Integer_value
	| '-' Integer_value
	| 
;

ptd_value:
	Unique_id
;

args_value:
	Unique_id
;

algn_value:
	Integer_value
;

used_value:
	Integer_value
;

scpe_value:
	Unique_id
;

clas_value:
	Unique_id
;

chan_value:
	Unique_id
;

orig_value:
	Unique_id
;

accs_value:
	Identifier
;

bpos_value:
	Unique_id
;

vfld_value:
	Unique_id
;

binf_value:
	Unique_id
;

labl_value:
	Unique_id
;

line_value:
	Integer_value
;

expr_value:
	Unique_id
;

qual_value:
	Identifier
;

cls_value:
	Unique_id
;

dcls_value:
	Unique_id
;

rslt_value:
	Unique_id
;

unql_value:
	Unique_id
;
tag_value
:
	Struct
	|Union
;

valu_value:
	Unique_id
	| ( Integer_value | '.' | 'e' | '+' | '-')+
	| ('+' | '-') Identifier
;

retn_value:
	Unique_id
;

prms_value:
	Unique_id
;

sign_value:
	Signed
	| Unsigned
;

min_value:
	Unique_id
;

max_value:
	Unique_id
;

argt_value:
	Unique_id
;

opr_value:
	Unique_id
;

strg_value
:
	Identifier
	| Integer_value
	| Identifier '#' Integer_value
	| strg_value Coloncolon Identifier  
	| 'e' 
	| Colon
	| C_attribute
	| Alignas
	| Alignof
	| Init
	| Asm
	| Low
	| Val
	| Min
	| Name
	| Max
	| Auto
	| Bool
	| Break
	| Case
	| Catch
	| Size
	| Opr
	| Base
	| Sign
	| Type
	| Char
	| Char16
	| Char32
	| Class
	| Const
	| Constexpr
	| Const_cast
	| Continue
	| Decltype
	| Decltype_
	| Decltype__
	| Default
	| Delete
	| Do
	| Double
	| Dynamic_cast
	| Else
	| Enum
	| Explicit
	| Export
	| Extern
	| False
	| Final
	| Float
	| For
	| Friend
	| Goto
	| If
	| Inline
	| Int
	| Long
	| Long strg_value
	| Mutable
	| Namespace
	| New
	| Noexcept
	| Nullptr
	| Operator
	| Override
	| Private
	| Protected
	| Public
	| Restrict
	| Register
	| Reinterpret_cast
	| Return
	| Short
	| Signed
	| Sizeof
	| Static
	| Static_assert
	| Static_cast
	| Struct
	| Switch
	| Template
	| This
	| Thread_local
	| Throw
	| True
	| Try
	| Typedef
	| Typeof
	| TypeofAfter__
	| TypeofBeforeAfter__
	| Typeid
	| Typename
	| Union
	| Unsigned
	| Using
	| Virtual
	| Void
	| Volatile
	| Wchar_t
	| While
	| Op
	| Cp
	| Lbracket
	| Rbracket
	| Obraces
	| Cbraces
	| Plus
	| Minus
	| Asterisk
	| Slash
	| Mod 
	| Mod Identifier
	| Caret
	| And
	| Or
	| Til
	| Not
	| Eq
	| Less
	| Greater
	| Addeq
	| Subeq
	| Muleq
	| Diveq
	| Modeq
	| Xoreq
	| Andeq
	| Oreq
	| Sl
	| Sleq
	| Equal
	| Noteq
	| Lteq
	| Gteq
	| Andand
	| Oror
	| Plusplus
	| Minusminus
	| Comma
	| Arrowstar
	| Arrow
	| Questionmark
	| Coloncolon
	| Semicolon
	| Dot
	| Dotstar
	| Ellipsis
;

name_value
:
	Unique_id
;

chain_value
:
	Unique_id
;

link_value
:
	Extern
	|Static
;

lngt_value
:
	Integer_value
;

srcp_value
:
	filename+ Colon linenumber
	| Builtin Colon linenumber
	
;

filename:
	Identifier
	| Plus
	| Plusplus
	| Minus
	| Slash
	| Dot
	| Alignas
	| Alignof
	| Asm
	| Auto
	| Type
	| Bool
	| Break
	| Case
	| Catch
	| Char
	| Char16
	| Char32
	| Class
	| Const
	| Constexpr
	| Const_cast
	| Continue
	| Decltype
	| Decltype_
	| Decltype__
	| Default
	| Delete
	| Do
	| Double
	| Dynamic_cast
	| Else
	| Enum
	| Explicit
	| Export
	| Extern
	| False
	| Final
	| Float
	| For
	| Friend
	| Goto
	| If
	| Inline
	| Int
	| Long
	| Long
	| Mutable
	| Namespace
	| New
	| Noexcept
	| Nullptr
	| Operator
	| Override
	| Private
	| Protected
	| Public
	| Restrict
	| Register
	| Reinterpret_cast
	| Return
	| Short
	| Signed
	| Sizeof
	| Static
	| Static_assert
	| Static_cast
	| Struct
	| Switch
	| Template
	| This
	| Thread_local
	| Throw
	| True
	| Try
	| Typedef
	| Typeof
	| TypeofAfter__
	| TypeofBeforeAfter__
	| Typeid
	| Typename
	| Union
	| Unsigned
	| Using
	| Virtual
	| Void
	| Volatile
	| Wchar_t
	| While
;

linenumber:
	Integer_value
;

type_value
:
	Unique_id
;

note_value
:
	Artificial
	| Constructor
	| Member
	| Destructor
	| Operator 
	| Operator Delete
	| Operator Identifier
	| Operator New
	| Operator Caret
	| Operator Andand
	| Operator Oror
	| Operator 
	| Identifier
	| Identifier Identifier
	
;

body_value
:
	Undefined
	| Unique_id
;

lang_value
:
	Identifier
;

size_value
:
	Unique_id
;

mngl_value
:
	Unique_id
;

Minus_token:
	'minus'
;

Tmpl:
	'tmpl'
;

Spec:
	'spec'
;

Ptd:
	'ptd'
;

Crnt:
	'crnt'
;

Args
:
	'args'
;

Builtin
:
	'<built-in>'
;

Scpe:
	'scpe'
;

Clas:
	'clas'
;

Chan:
	'chan'
;

Orig:
	'orig'
;

Accs:
	'accs'
;

Bpos:
	'bpos'
;

Vfld:
	'vfld'
;

Binf:
	'binf'
;

Argt:
	'argt'
;

Labl:
	'labl'
;

Bitfield:
	'bitfield'
;

Line:
	'line'
;

Expr:
	'expr'
;

Qual:
	'qual'
;

Cnst:
	'cnst'
;

Dcls:
	'dcls'
;

Cls:
	'cls'
;

Inst:
	'inst'
;

Elts:
	'elts'
;

Rslt:
	'rslt'
;

Unql:
	'unql'
;

Tag:
	'tag'
;

Valu:
	'valu'
;

Retn:
	'retn'
;

Prms:
	'prms'
;

Spcs:
'spcs'
;

Purp:
	'purp'
;

Cond:
	'cond'
;

Sign:
	'sign'
;

Min:
	'min'
;

Max:
	'max'
;

Init
:
	'init'
;

Opr
:
	'op'
;

Strg:
	'strg'
;

Name:
	'name'
;

Flds:
	'flds'
;

Domn:
	'domn'
;

Chain:
	'chain'
;

Link:
	'link'
;

Bfld:
	'bfld'
;

Lngt:
	'lngt'
;

Srcp:
	'srcp'
;

Type:
	'type'
;

Note:
	'note'
;

Body:
	'body'
;

Lang:
	'lang'
;

Size:
	'size'
;

Mngl:
	'mngl'
;

Used:
	'used'
;

Clnp:
	'clnp'
;
Val:
	'val'
;


Bases:
	'bases'
;

Csts:
	'csts'
;

Decl:
	'decl'
;

Base:
	'base'
;

Algn:
	'algn'
;

Prec:
	'prec'
;

Refd:
	'refd'
;

Idx:
	'idx'
;	

Then:
	'then'
;

Vars
:
	'vars'
;

Fncs:
	'fncs'
;

Low:
	'low'
;

Parm:
	'parm'
;

Fn
:
	'fn'
;

Hdlr:
'hdlr'
;

Ctor:
	'ctor'
;

Colon:
	':'
;

Artificial:
	'artificial'
;

Destructor:
	'destructor'
;

Constructor:
	'constructor'
;

Member:
	'member'
;

Undefined:
	'undefined'
;

C_attribute
:
	'__attribute__' 
	|'__attribute'
	|'attribute'
;

Alignas 
:
	'_Alignas' 
	|'alignas'
;

Alignof
:
	'alignof'
	| '_Alignof'
	| '__alignof__'
;

Asm
:
	'asm'
	| '__asm'
	| '__asm__'
;

Auto
:
	'auto'
;

Bool
:
	'bool'
	| '_Bool'
;

Break
:
	'break'
;

Case
:
	'case'
;

Catch
:
	'catch'
	| '__catch'
;

Char
:
	'char'
;

Char16
:
	'char16_t'
;

Char32
:
	'char32_t'
;

Class
:
	'class'
;

Const
:
	'const'
;

Constexpr
:
	'constexpr'
;

Const_cast
:
	'const_cast'
;

Continue
:
	'continue'
;

Decltype
:
	'decltype'
;

Decltype_
:
	'__decltype'
;

Decltype__
:
	'__decltype__'
;

Default
:
	'default'
;

Delete
:
	'delete'
;

Do
:
	'do'
;

Double
:
	'double'
;

Dynamic_cast
:
	'dynamic_cast'
;

Else
:
	'else'
;

Enum
:
	'enum'
;

Explicit
:
	'explicit'
;

Export
:
	'export'
;

Extern
:
	'extern'
;

False
:
	'false'
;

Final
:
	'final'
;

Float
:
	'float'
;

For
:
	'for'
;

Friend
:
	'friend'
;

Goto
:
	'goto'
;

If
:
	'if'
;

Inline
:
	'inline'
;

Int
:
	'int'
;

Long
:
	'long'
;

Mutable
:
	'mutable'
;


Namespace
:
	'namespace'
;

New
:
	'new'
;

Noexcept
:
	'noexcept'
;

Nullptr
:
	'nullptr'
;

Operator
:
	'operator'
;

Override
:
	'override'
;

Private
:
	'private'
;

Protected
:
	'protected'
;

Public
:
	'public'
;

Restrict
:
	'__restrict'
	|'__restrict__'
;

Register
:
	'register'
;

Reinterpret_cast
:
	'reinterpret_cast'
;

Return
:
	'return'
;

Short
:
	'short'
;

Signed
:
	'signed'
;

Sizeof
:
	'sizeof'
;

Static
:
	'static'
;

Static_assert
:
	'static_assert'
;

Static_cast
:
	'static_cast'
;

Struct
:
	'struct'
;

Switch
:
	'switch'
;

Template
:
	'template'
;

This
:
	'this'
;

Thread_local
:
	'thread_local'
;

Throw
:
	'throw'
;

True
:
	'true'
;

Try
:
	'try'
;

Typedef
:
	'typedef'
;

Typeof
:
	'typeof'
	|'__underlying_type'
;
TypeofAfter__
:
	'typeof__'
;
TypeofBeforeAfter__
:
	'__typeof__'
;

Typeid
:
	'typeid'
;

Typename
:
	'typename'
;

Union
:
	'union'
;

Unsigned
:
	'unsigned'
;

Using
:
	'using'
;

Virtual
:
	'virtual'
;

Void
:
	'void'
;

Volatile
:
	'volatile' 
;

Wchar_t
:
	'wchar_t'
;

While
:
	'while'
;

/*operators*/
Op
:
	'('
;

Cp
:
	')'
;

Lbracket
:
	'['
;

Rbracket
:
	']'
;

Obraces
:
	'{'
;

Cbraces
:
	'}'
;

Plus
:
	'+'
;

Minus
:
	'-'
;

Asterisk
:
	'*'
;

Slash
:
	'/'
;

Mod
:
	'%'
;

Caret
:
	'^'
	|'xor'
;

And
:
	'&'
	|'bitand'
;

Or
:
	'|'
	|'bitor'
;

Til
:
	'~'
	|'compl'
;

Not
:
	'!'
;

Eq
:
	'='
;

Less
:
	'<'
;

Greater
:
	'>'
;

Addeq
:
	'+='
;

Subeq
:
	'-='
;

Muleq
:
	'*='
;

Diveq
:
	'/='
;

Modeq
:
	'%='
;

Xoreq
:
	'^='
	|'xor_eq'
;

Andeq
:
	'&='
	|'and_eq'
;

Oreq
:
	'|='
	|'or_eq'
;

Sl
:
	'<<'
;

Sleq
:
	'<<='
;

Equal
:
	'=='
;

Noteq
:
	'!='
	|'not_eq'
;

Lteq
:
	'<='
;

Gteq
:
	'>='
;

Andand
:
	'&&'
	|'and'
;

Oror
:
	'||'
	|'or'
;

Plusplus
:
	'++'
;

Minusminus
:
	'--'
;

Comma
:
	','
;

Arrowstar
:
	'->*'
;

Arrow
:
	'->'
;

Questionmark
:
	'?'
;

Coloncolon
:
	'::'
;

Semicolon
:
	';'
;

Dot
:
	'.'
;

Dotstar
:
	'.*'
;

Ellipsis
:
	'...'
;

Integer_value
:
	Decimalliteral Integersuffix?
	| Octalliteral Integersuffix?
	| Hexadecimalliteral Integersuffix?
	| Binaryliteral Integersuffix?
;

Decimalliteral
:
	NONZERODIGIT
	(
		'\''? DIGIT
	)*
;

Octalliteral
:
	'0'
	(
		'\''? OCTALDIGIT
	)*
;

Hexadecimalliteral
:
	(
		'0x'
		| '0X'
	) HEXADECIMALDIGIT
	(
		'\''? HEXADECIMALDIGIT
	)*
;

Binaryliteral
:
	(
		'0b'
		| '0B'
	) BINARYDIGIT
	(
		'\''? BINARYDIGIT
	)*
;
fragment
NONZERODIGIT
:
	[1-9]
;

fragment
OCTALDIGIT
:
	[0-7]
;

fragment
HEXADECIMALDIGIT
:
	[0-9a-fA-F]
;

fragment
BINARYDIGIT
:
	[01]
;

Integersuffix
:
	Unsignedsuffix Longsuffix?
	| Unsignedsuffix Longlongsuffix?
	| Longsuffix Unsignedsuffix?
	| Longlongsuffix Unsignedsuffix?
;

fragment
Unsignedsuffix
:
	[uU]
;

fragment
Longsuffix
:
	[lL]
;

fragment
Longlongsuffix
:
	'll'
	| 'LL'
;


Unique_id: 	'@' DIGIT+ ;

Identifier:	
	NONDIGIT (NONDIGIT|DIGIT)* 
;

fragment
NONDIGIT
:
	[a-zA-Z_%]
;

fragment 
DIGIT
:
	[0-9]
;

Whitespace:	[ \t]+ -> channel(HIDDEN) ;

Newline:
	(
		'\r' '\n'?
		| '\n'
	) -> channel(HIDDEN)
;

