#!/bin/bash

# merge 하려는 브랜치
merge_branch=develop

# 현재 브랜치 확인
current_branch=$(git rev-parse --abbrev-ref HEAD)

if [[ -n $(git status --porcelain) ]]; then
  echo "커밋되지 않은 변경사항이 존재합니다."
  exit 1
fi
if [[ "$current_branch" != Card* ]]; then
    echo "오류: 작업 브랜치명은 'Card'로 시작해야 합니다."
    read -p "무시하고 계속 진행하시겠습니까? 계속 진행하려면 '$merge_branch' 이라고 입력하세요: " user_input
    if [[ "$user_input" != "$merge_branch" ]]; then
        echo "진행이 취소되었습니다."
        exit 1
    fi
fi

# 'master' 동기화
git checkout master || { echo "⛔️ master 브랜치로 전환할 수 없습니다."; exit 1; }
git pull origin master || { echo "⛔️ master 브랜치를 가져올 수 없습니다."; exit 1; }

# 현재 브랜치로 돌아가기
git checkout "$current_branch" || { echo "⛔️ $current_branch 브랜치로 전환할 수 없습니다."; exit 1; }
git merge master -m "Merged master into $current_branch" || { echo "⛔️ master와 병합할 수 없습니다."; exit 1; }

# 'develop' 브랜치로 체크아웃
git checkout develop || { echo "⛔️ develop 브랜치로 전환할 수 없습니다."; exit 1; }
git pull origin develop || { echo "⛔️ develop 브랜치를 가져올 수 없습니다."; exit 1; }

# 작업 브랜치를 'develop'에 병합
git merge "$current_branch" -m "Merged $current_branch into develop" || { echo "⛔️ $current_branch를 develop과 병합할 수 없습니다."; exit 1; }

# 변경 사항을 원격 저장소에 푸시
git push origin develop || { echo "⛔️ develop 브랜치를 원격 저장소에 푸시할 수 없습니다."; exit 1; }

# 작업 브랜치로 돌아가기
git checkout "$current_branch" || { echo "⛔️ $current_branch 브랜치로 돌아갈 수 없습니다."; exit 1; }

echo "🎉 작업이 완료되었습니다. 🥳"
