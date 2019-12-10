select
    -- Dimensoes
    loja.loj_denloj      as loja_descricao,

    cliente.pes_codpes   as cliente_codigo,
    cliente.pes_nome     as cliente_descricao,
    cliente.pes_bairro   as cliente_bairro,

    tab_grupo.grp_dscgrp as produto_grupo,

    vendedor.pes_codpes  as vendedor_codigo,
    vendedor.pes_nome    as vendedor_nome,

    fatura.fat_sitfat    as situacao_fatura,

    fornecedor.pes_codpes as fornecedor_codigo,
    fornecedor.pes_nome   as fornecedor_nome,

    fatura.fat_forpag          as fatura_forma_pgto_codigo,
    tab_forma_pag.fpg_desfpg   as fatura_forma_pgto_descricao,


    -- Fatos
    item_fatura.ift_valor      as valor_venda,
    item_fatura.ift_custitm    as valor_compra,
    item_fatura.ift_quantped   as qtde_itens

from fatura
        left outer join item_fatura
        on ( item_fatura.ift_empresa = fatura.fat_empresa and
             item_fatura.ift_loja    = fatura.fat_loja    and
             item_fatura.ift_undadm  = fatura.fat_undadm
           )

        left outer join item
        on ( item.itm_item = item_fatura.ift_item )

        left outer join tab_grupo
        on ( tab_grupo.grp_codgrp = item.itm_grupo )

        left outer join loja
        on ( loja.loj_codemp = fatura.fat_empresa  and
             loja.loj_codloj = fatura.fat_loja
           )

        left outer join pessoa as cliente
        on ( cliente.pes_codpes = fatura.fat_codpes )

        left outer join pessoa as vendedor
        on ( vendedor.pes_codpes = fatura.fat_codven )

        left outer join pessoa as fornecedor
        on ( fornecedor.pes_codpes = item.itm_codfab )

        left outer join tab_forma_pag
        on ( tab_forma_pag.fpg_forpag = fatura.fat_forpag )

where fatura.fat_tipped = 'V'
;