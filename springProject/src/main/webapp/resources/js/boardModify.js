async function removeFile(uuid) {
    try {
        const url = '/board/file/' + uuid;
        const config = {
            method: 'DELETE'
        };
        const resp = await fetch(url, config);
        const result = await resp.text();
        return result;

    } catch (err) {
        console.log(err);
    }
}


document.addEventListener('click', (e) => {
    console.log(e.target);
    if (e.target.classList.contains('file-x')) {
        console.log('삭제버튼 클릭');
    }

    let uuid = e.target.dataset.uuid;
    console.log(uuid);


    removeFile(uuid).then(result => {
        if (result == '1') {
            e.target.closest('li').remove();
//            window.location.reload();

            alert('파일 삭제 성공~!!');


        } else if (result == '2') {
            alert('파일 삭제 실패ㅠㅠ');
        }

    }
    )

})