console.log(bnoVal);

// 댓글 목록을 가져와서 페이지 로드 시 표시
getCommentList(bnoVal);

async function postCommentToServer(cmtData) {
    try {
        const url = "/comment/post";
        const config = {
            method: "post",
            headers: {
                'content-type': 'application/json; charset=utf-8'
            },
            body: JSON.stringify(cmtData)
        };

        const resp = await fetch(url, config);
        const result = await resp.json();  // isOk
        return result;
    } catch (err) {
        console.log(err);
    }
}

document.getElementById('cmtPostBtn').addEventListener('click', () => {
    const cmtText = document.getElementById('cmtText').value;
    const cmtWriter = document.getElementById('cmtWriter').innerText;
    if (cmtText == "" || cmtText == null) {
        alert("댓글을 입력해주세요.");
        document.getElementById('cmtText').focus();
        return false;
    } else {
        let cmtData = {
            bno: bnoVal,
            writer: cmtWriter,
            content: cmtText
        };
        console.log(cmtData);
        postCommentToServer(cmtData).then(result => {
            console.log(result);
            // isOk 확인
            if (result == 1) {
                document.getElementById('cmtText').value = "";
                alert('댓글 등록 성공~!!');

                // 화면에 뿌리기
                window.location.reload();
                getCommentList(bnoVal);
                // 댓글 등록 후 내용 지우기
            }
        })
    }
})

async function spreadCommentListFromServer(bno, page) {
    console.log(bno);

    try {
        const resp = await fetch('/comment/' + bno + '/' + page);
        const result = await resp.json();
        return result;
    } catch (err) {
        console.log(err);
    }
}

// 처음에 무조건 첫 번째 페이징 값을 뿌림
function getCommentList(bno, page = 1) {
    // 서버로부터 댓글 목록을 가져옴
    spreadCommentListFromServer(bno, page).then(result => {
        console.log(result);
        const ul = document.getElementById('cmtListArea');
        if (result.cmtList.length > 0) {
            // 다시 댓글을 뿌릴 때 기존 값 삭제 (1페이지일 경우만)
            if (page == 1) {
                ul.innerHTML = "";
            }
        }

        if (result.cmtList.length > 0) {
            for (let cvo of result.cmtList) {
                let li = `<li data-cno="${cvo.cno}" data-writer="${cvo.writer}" class="list-group-item">`;
                li += `<div class="mb-3">`;
                li += `<div class="fw-bold writer">${cvo.writer}</div>`;
                li += `${cvo.content}`;
                li += `</div>`;
                if (cvo.regAt == cvo.modAt) {
                    li += `<span class="badge rounded-pill text-bg-light">${cvo.regAt}</span><br>`;
                }
                else {
                    li += `<span class="badge rounded-pill text-bg-light">(수정됨)${cvo.modAt}</span><br>`;
                }

                if (cvo.writer === authEmail) {
                    console.log(result.cmtList.writer)
                    li += `<button type="button" class="modBtn btn btn-outline-success" data-bs-toggle="modal" data-bs-target="#myModal">%</button>`;
                    li += `<button type="button" class="delBtn btn btn-outline-danger">X</button>`;
                }

                li += `</li>`;

                ul.innerHTML += li;
            }

            // 댓글 페이징 코드 
            let moreBtn = document.getElementById('moreBtn');
            if (result.pgvo.pageNo < result.endPage) {
                moreBtn.style.visibility = 'visible';
                moreBtn.dataset.page = page + 1;
            } else {
                moreBtn.style.visibility = 'hidden';
            }
        } else {
            let li = `<li>Comment List Empty</li>`;
            ul.innerHTML = li;
        }
    })
}

async function removeCommentToServer(cno, writer) {
    try {
        const url = '/comment/del/' + cno + '/' + writer;
        const config = {
            method: 'delete'
        };
        console.log(">>url" + url);
        const resp = await fetch(url, config);
        const result = await resp.json();
        return result;
    } catch (err) {
        console.log(err);
    }
}

document.addEventListener('click', (e) => {
    console.log(e.target);

    if (e.target.classList.contains('delBtn')) {
        console.log('삭제 클릭');
        let li = e.target.closest('li');
        let cnoVal = li.dataset.cno;
        let writerVal = li.dataset.writer;
        console.log(writerVal);
        removeCommentToServer(cnoVal, writerVal).then(result => {
            if (result == 1) {
                console.log(" >>>> cno/ writer >> " + cnoVal + " / " + writerVal);
                alert('댓글 삭제 성공');
            } else {
                console.log(" >>>> cno/ writer >> " + cnoVal + " / " + writerVal);
                alert('댓글 삭제 실패');
            }
            getCommentList(bnoVal);
        });
    } else if (e.target.classList.contains('modBtn')) {
        console.log('수정 클릭');
        let li = e.target.closest('li');
        let writerVal = li.dataset.writer;
        // nextSibling(): 같은 부모의 다음 형제 객체를 반환
        let cmtText = li.querySelector('.fw-bold').nextSibling;
        // 기존 내용 모달창에 반영 (수정 편하게...)
        document.getElementById('cmtTextMod').value = cmtText.nodeValue;

        // cmtModBtn에 data-cno 달기
        document.getElementById('cmtModBtn').setAttribute('data-cno', writerVal, li.dataset.cno);
    } else if (e.target.id == 'cmtModBtn') {
        let cmtDataMod = {
            cno: e.target.dataset.cno,
            content: document.getElementById('cmtTextMod').value
        };

        console.log(cmtDataMod);

        editCommentToServer(cmtDataMod).then(result => {
            if (parseInt(result)) {
                alert('댓글 수정 성공');
                document.querySelector('.btn-close').click();
                location.reload();
            }
        });
    } else if (e.target.id == 'moreBtn') {
        getCommentList(bnoVal, parseInt(e.target.dataset.page));
    }
})
